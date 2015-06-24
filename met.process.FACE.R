# This is a terrible script for processing FACE data, which may be the end of me. 

met.process.FACE <- function(site, input_met, start_date, end_date, model, host, dbparms, dir, browndog=NULL){
  
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
  
  if(stage$download.raw==TRUE){
  outfolder  <- file.path(dir,met)
  pkg        <- "PEcAn.data.atmosphere"
  fcn        <- paste0("download.",met)
  
 if(register$scale=="site") { # Site-level met
    
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
  }
  }
  
  #--------------------------------------------------------------------------------------------------#
  # Change to  CF Standards
    
  if(stage$met2cf == TRUE){
  logger.info("Begin change to CF Standards")
  
  input.id  <-  raw.id[1]
  pkg       <- "PEcAn.data.atmosphere"
  formatname <- 'CF Meteorology'
  mimetype <- 'application/x-netcdf'
  format.id <- 33
  
  
 if(register$scale=="site"){   
    
    input_name <- paste0(met,"_CF_site_",str_ns)
    outfolder  <- file.path(dir,input_name)
    
    print("start CHECK")   
    check = db.query(
      paste0("SELECT i.start_date, i.end_date, d.file_path, d.container_id, d.id  from dbfiles as d join inputs as i on i.id = d.container_id where i.site_id =",new.site$id,
             " and d.container_type = 'Input' and i.format_id=",33, " and d.machine_id =",machine$id, " and i.name = '", input_name,
             "' and (i.start_date <= DATE '",as.POSIXlt(start_date, tz = "GMT"),"') and (DATE '", as.POSIXlt(end_date, tz = "GMT"),"' <= i.end_date)" ),con)
    print("end CHECK")
    options(digits=10)
    print(check)
    if(length(check)>0){
      cf.id <- list(input.id=check$container_id, dbfile.id=check$id)
    }  
    
    fcn1 <- paste0("met2CF.",met)
    fcn2 <- paste0("met2CF.",register$format$mimetype)
    if(exists(fcn1)){
      fcn <- fcn1
    }else if(exists(fcn2)){
      fcn <- fcn2
    }else{logger.error("met2CF function doesn't exists")}
    
    cf.id <- convert.input(input.id,outfolder,formatname,mimetype,site.id=site$id,start_date,end_date,pkg,fcn,
                           username,con=con,hostname=host$name,browndog=NULL,write=TRUE) 
  }
  
  logger.info("Finished change to CF Standards")
  }
  
  
  #--------------------------------------------------------------------------------------------------#
  # Prepare for Model
  
  if(stage$met2model == TRUE){
  logger.info("Begin Model Specific Conversion")
  
  # Determine output format name and mimetype   
  model_info <- db.query(paste0("SELECT f.name, f.id, f.mime_type from modeltypes as m join modeltypes_formats as mf on m.id
                                = mf.modeltype_id join formats as f on mf.format_id = f.id where m.name = '",model,"' AND mf.tag='met'"),con)
  formatname <- model_info[1]
  mimetype   <- model_info[3]   
  
  print("# Convert to model format")
  
  input.id  <- ready.id[1]
  outfolder <- file.path(dir,paste0(met,"_",model,"_site_",str_ns))
  pkg       <- paste0("PEcAn.",model)
  fcn       <- paste0("met2model.",model)
  lst       <- site.lst(site,con)
    
  model.id  <- convert.input(input.id,outfolder,formatname,mimetype,site.id=site$id,start_date,end_date,pkg,fcn,
                             username,con=con,hostname=host$name,browndog,write=TRUE,lst=lst,lat=new.site$lat,lon=new.site$lon)
  }
  
  logger.info(paste("Finished Model Specific Conversion",model.id[1]))
  
  model.file <- db.query(paste("SELECT * from dbfiles where id =",model.id[[2]]),con)[["file_name"]]
  
  db.close(con)
  return(file.path(outfolder, model.file))
  
}

#################################################################################################################################

##' @name db.site.lat.lon
##' @title db.site.lat.lon
##' @export
##' @param site.id
##' @param con
##' @author Betsy Cowdery
##' 
db.site.lat.lon <- function(site.id,con){
  site <- db.query(paste("SELECT id, ST_X(ST_CENTROID(geometry)) AS lon, ST_Y(ST_CENTROID(geometry)) AS lat FROM sites WHERE id =",site.id),con)
  if(nrow(site)==0){logger.error("Site not found"); return(NULL)} 
  if(!(is.na(site$lat)) && !(is.na(site$lat))){
    return(list(lat = site$lat, lon = site$lon))
  }
}

#################################################################################################################################

##' @name site_from_tag
##' @title site_from_tag
##' @export
##' @param sitename
##' @param tag
##' @author Betsy Cowdery
##' 
##' Function to find the site code for a specific tag 
##' Example: 
##'   sitename = "Rhinelander Aspen FACE Experiment (FACE-RHIN)" 
##'   tag = "FACE"
##'   site_from_tag(sitename,tag) = "RHIN"
##' Requires that site names be set up specifically with (tag-sitecode) - this may change


site_from_tag <- function(sitename,tag){
  temp <- regmatches(sitename,gregexpr("(?<=\\().*?(?=\\))", sitename, perl=TRUE))[[1]]
  pref <- paste0(tag,"-")
  site <- unlist(strsplit(temp[grepl(pref,temp)], pref))[2]
  return(site)
}

