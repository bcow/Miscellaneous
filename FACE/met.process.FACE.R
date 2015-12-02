
# This is a terrible script for processing FACE data, which may be the end of me. 

rm(list = setdiff(ls(), lsf.str()))  # clear variables but not sourced functions
for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections

require(PEcAn.all)
require(PEcAn.data.atmosphere)

xml_file <- "/home/ecowdery/GitHub_Miscellaneous/FACE/FACE.pecan2_pecan.xml"
settings <- read.settings(xml_file)
# settings <- xmlToList(xmlParse(xml_file))
# settings <- xmlToList(xmlParse("/home/ecowdery/GitHub_Miscellaneous/FACE/FACE.geo_pecan.xml"))

site       = settings$run$site 
input_met  = settings$run$inputs$met
start_date = settings$run$start.date 
end_date   = settings$run$end.date
model      = settings$model$type
host       = settings$run$host
dbparms    = settings$database$bety 
dir        = settings$run$dbfiles
browndog   = settings$browndog

require(RPostgreSQL)
require(XML)

#setup connection and host information
con      <- db.open(dbparms)
username <- ""  
ifelse(host$name == "localhost", machine.host <- fqdn(), machine.host <- host$name)
machine = db.query(paste0("SELECT * from machines where hostname = '",machine.host,"'"),con)

#get met source and potentially determine where to start in the process
met <- ifelse(is.null(input_met$source), logger.error("Must specify met source"),input_met$source)  

#read in registration xml for met specific information
register.xml <- system.file(paste0("registration/register.", met, ".xml"), package = "PEcAn.data.atmosphere")
register <- read.register(register.xml, con)

# first attempt at function that designates where to start met.process
if(is.null(input_met$id)){
  stage <- list(download.raw = TRUE, met2cf = TRUE, standardize = TRUE, met2model = TRUE)
}else{
  stage <- met.process.stage(input_met$id,register$format$id,con)
  # Is there a situation in which the input ID could be given but not the file path? 
  # I'm assuming not right now
  assign(stage$id.name,list(
    inputid = input_met$id, 
    dbfileid = db.query(paste0("SELECT id from dbfiles where file_name = '", basename(input_met$path) ,"' AND file_path = '", dirname(input_met$path) ,"'"),con)[[1]]
  ))
}

#setup additional browndog arguments
if(!is.null(browndog)){browndog$inputtype <- register$format$inputtype}

#setup site database number, lat, lon and name
new.site <- data.frame(id = as.numeric(site$id), lat = db.site.lat.lon(site$id,con=con)$lat, lon = db.site.lat.lon(site$id,con=con)$lon)
str_ns    <- paste0(new.site$id %/% 1000000000, "-", new.site$id %% 1000000000)  

#--------------------------------------------------------------------------------------------------#
# Download raw met from the internet 

outfolder  <- file.path(dir,met)
pkg        <- "PEcAn.data.atmosphere"
fcn        <- paste0("download.",met)

print("start CHECK")
check = db.query(
  paste0("SELECT i.start_date, i.end_date, d.file_path, d.container_id, d.id  from dbfiles as d join inputs as i on i.id = d.container_id where i.site_id =",site$id,
         " and d.container_type = 'Input' and i.format_id=",register$format$id, " and d.machine_id =",machine$id,
         " and (i.start_date <= DATE '",as.POSIXlt(start_date, tz = "GMT"),"') and (DATE '", as.POSIXlt(end_date, tz = "GMT"),"' <= i.end_date)" ),con)
print("end CHECK")
options(digits=10)
print(check)

if(length(check)>0){
  raw.id <- list(input.id=check$container_id, dbfile.id=check$id)
}else{
  
  outfolder = paste0(outfolder,"_site_",str_ns)
  args <- list(site$name, outfolder, start_date, end_date)
  
  cmdFcn  = paste0(pkg,"::",fcn,"(",paste0("'",args,"'",collapse=","),")")
  new.files <- remote.execute.R(script=cmdFcn,host=host$name,user=NA,verbose=TRUE,R="R")
  
  raw.path <- dirname(new.files$file[1])
  
  ## insert database record
  raw.id <- dbfile.input.insert(in.path=dirname(new.files$file[1]),
                                in.prefix=new.files$dbfile.name[1], 
                                siteid = site$id, 
                                startdate = start_date, 
                                enddate = end_date, 
                                mimetype=new.files$mimetype[1], 
                                formatname=new.files$formatname[1],
                                parentid=NA,
                                con = con,
                                hostname = host$name)
}    


#--------------------------------------------------------------------------------------------------#
# Change to  CF Standards

input.id  <-  raw.id[1]
pkg       <- "PEcAn.data.atmosphere"
formatname <- 'CF Meteorology'
mimetype <- 'application/x-netcdf'
format.id <- 33


input_name <- paste0(met,"_CF_site_",str_ns)
outfolder  <- file.path(dir,input_name)

a_input_name <- input_name <- paste0(met,"_a_CF_site_",str_ns)
e_input_name <- input_name <- paste0(met,"_e_CF_site_",str_ns)

acheck = db.query(
  paste0("SELECT i.start_date, i.end_date, d.file_path, d.container_id, d.id  from dbfiles as d join inputs as i on i.id = d.container_id where i.site_id =",new.site$id,
         " and d.container_type = 'Input' and i.format_id=",33, " and d.machine_id =",machine$id, " and i.name = '", a_input_name,
         "' and (i.start_date <= DATE '",as.POSIXlt(start_date, tz = "GMT"),"') and (DATE '", as.POSIXlt(end_date, tz = "GMT"),"' <= i.end_date)" ),con)

echeck = db.query(
  paste0("SELECT i.start_date, i.end_date, d.file_path, d.container_id, d.id  from dbfiles as d join inputs as i on i.id = d.container_id where i.site_id =",new.site$id,
         " and d.container_type = 'Input' and i.format_id=",33, " and d.machine_id =",machine$id, " and i.name = '", e_input_name,
         "' and (i.start_date <= DATE '",as.POSIXlt(start_date, tz = "GMT"),"') and (DATE '", as.POSIXlt(end_date, tz = "GMT"),"' <= i.end_date)" ),con)


options(digits=10)
print(acheck)
print(echeck)


if(length(acheck)>0 & length(echeck)>0){
  cf.id.a <- list(input.id=acheck$container_id, dbfile.id=acheck$id)
  cf.id.e <- list(input.id=echeck$container_id, dbfile.id=echeck$id)
}else{
  
  files <- db.query(paste("SELECT file_path from dbfiles where container_id =", raw.id[1] ),con)[[1]]
  in.path <- files[grep(pattern=paste0("*FACE*"),files)]
  in.prefix <- "FACE"
  outfolder <- outfolder
  
  source('~/pecan/modules/data.atmosphere/R/met2CF.FACE.R')
  met2CF.FACE(in.path,in.prefix,outfolder,start_date,end_date,site)
  
}

##################################################################################################


in.prefix <- "FACE"
siteid <- site$id
startdate <- start_date
enddate <- end_date
mimetype <- "application/x-netcdf"
formatname <- "CF Meteorology"
parentid <- raw.id[[1]]
con <- con
hostname <- host$name


in.path <- file.path(dir, a_input_name)
cf.id.a <- dbfile.input.insert(in.path,in.prefix, siteid, startdate, enddate, mimetype, formatname, 
                               parentid,con,hostname)


in.path <- file.path(dir, e_input_name)
cf.id.e <- dbfile.input.insert(in.path,in.prefix, siteid, startdate, enddate, mimetype, formatname, 
                               parentid,con,hostname)  

class(cf.id.a$input.id)

cf.id.e$input.id <- cf.id.e$input.id[1]





#--------------------------------------------------------------------------------------------------#
# Prepare for Model


# Determine output format name and mimetype
model_info <- db.query(paste0("SELECT f.name, f.id, mt.type_string from modeltypes as m",
                              " join modeltypes_formats as mf on m.id = mf.modeltype_id",
                              " join formats as f on mf.format_id = f.id",
                              " join mimetypes as mt on f.mimetype_id = mt.id",
                              " where m.name = '", model, "' AND mf.tag='met'"),con)
formatname <- model_info[1]
mimetype   <- model_info[3]

########################################################
# ambient model data 

input.id  <- cf.id.a[1]
outfolder <- file.path(dir,paste0(met,"_a_",model,"_site_",str_ns))
pkg       <- paste0("PEcAn.",model)
fcn       <- paste0("met2model.",model)
lst       <- site.lst(site,con)

model.id.a  <- convert.input(input.id,outfolder,formatname,mimetype,site.id=site$id,start_date,end_date,
                           pkg,fcn,username,con=con,hostname=host$name,browndog=NULL,write=TRUE,lst=lst,
                           lat=new.site$lat,lon=new.site$lon)

# site.id=site$id
# hostname=host$name
# browndog=NULL
# write=TRUE
# l <- list(
#   lst=lst,
#   lat=new.site$lat,
#   lon=new.site$lon)
# 
# 
met2model.ED2(
  in.path = file.path(dir, a_input_name),
  in.prefix = 'FACE',
  outfolder = outfolder,
  start_date = start_date,
  end_date = end_date,
  lst=lst,
  lat=new.site$lat,
  lon=new.site$lon)



########################################################
# elevated model data 

input.id  <- cf.id.e[1]
outfolder <- file.path(dir,paste0(met,"_e_",model,"_site_",str_ns))
pkg       <- paste0("PEcAn.",model)
fcn       <- paste0("met2model.",model)
lst       <- site.lst(site,con)

model.id.e  <- convert.input(input.id,outfolder,formatname,mimetype,site.id=site$id,start_date,end_date,
                           pkg,fcn,username,con=con,hostname=host$name,browndog=NULL,write=TRUE,lst=lst,
                           lat=new.site$lat,lon=new.site$lon)

# site.id=site$id
# hostname=host$name
# write=TRUE
# l <- list(
#   lst=lst,
#   lat=new.site$lat,
#   lon=new.site$lon)


met2model.ED2(
  in.path = file.path(dir, e_input_name),
  in.prefix = 'FACE',
  outfolder = outfolder,
  start_date = start_date,
  end_date = end_date,
  lst=lst,
  lat=new.site$lat,
  lon=new.site$lon)



#########################################################
#
#   RHIN 
#   <site>
#   <id>1000000008</id>
#   <name>Rhinelander Aspen FACE Experiment (FACE-RHIN)</name>
#   <lat>45.6</lat>
#   <lon>-89.5</lon>
#   </site>
#   
#   <start.date>1998-01-01 00:00:00</start.date>
#   <end.date>2008-12-31 00:00:00</end.date>
#
#########################################################
#
#   PHAC
#   <site>
#   <id>1000000007</id>
#   <name>Prairie Heating and CO2 Enrichment Experiment (FACE-PHAC)</name>
#   <lat>41.18</lat>
#   <lon>-104.90</lon>
#   </site>
#   
#   <start.date>2006-01-01 00:00:00</start.date>
#   <end.date>2013-12-31 00:00:00</end.date>
#
#########################################################
# 
#   KSCO
#   <site>
#   <id>1000000004</id>
#   <name>Florida Scrub Oak Open Top Chamber Site (FACE-KSCO)</name>
#   <lat>28.63</lat>
#   <lon>-80.7</lon>
#   </site>
#   
#   <start.date>1996-01-01 00:00:00</start.date>
#   <end.date>2007-12-31 00:00:00</end.date>
#
#########################################################
#
#   NDFF
#   <site>
#   <id>1000000005</id>
#   <name>Nevada Desert FACE Facility (FACE-NDFF)</name>
#   <lat>36.77</lat>
#   <lon>-115.96</lon>
#   </site>
#   
#   <start.date>1997-01-01 00:00:00</start.date>
#   <end.date>2007-12-31 00:00:00</end.date>
#
#########################################################






