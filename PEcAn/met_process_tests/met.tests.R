rm(list = setdiff(ls(), lsf.str()))  # clear variables but not sourced functions
for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections

require(PEcAn.all)
# PEcAn.data.atmosphere::

xml_file <- "tests/pecan2.tests.xml"
#settings <- read.settings(xml_file)
settings <- xmlToList(xmlParse(xml_file))

# read.settings("pecan.xml")


site       = settings$run$site 
start_date = settings$run$start.date 
end_date   = settings$run$end.date
model      = settings$model$type
host       = settings$run$host
dbparms    = settings$database$bety 
dir        = settings$run$dbfiles
input_met  = settings$run$inputs$met
browndog   = settings$browndog

final_folder <- met.process(site, input_met, start_date, end_date, model, host, dbparms, dir, browndog)

settings$browndog <- NULL

site.id=site$id
hostname=host$name
write=TRUE
l <- list()
l <- list(lst=lst)
l <- list(slat=new.lat,slon=new.lon,newsite=new.site)





source('~/GitHub_Miscellaneous/PEcAn/refresh.pecan.R')
refresh.pecan()


library(XML)
library(lubridate)
library(PEcAn.DB)
library(PEcAn.utils)


xmldata2 <- paste0("<input>",
                  "<type>",tolower(met), "</type>",
                  "<site>", site.dl, "</site>",
                  "<start_date>", start_date, "</start_date>",
                  "<end_date>", end_date, "</end_date>",
                  "</input>")



xml <- xmlToList(xmlParse("/home/ecowdery/GitHub_Miscellaneous/PEcAn/met_process_tests/pecan_geo.xml"))


site.id=site$id
hostname=host$name
write=TRUE
l <- list(lst=lst)
l <- list()
l <- list(slat=new.lat,slon=new.lon,newsite=new.site)


(cmdFcn,hostname,verbose=TRUE)


script <- cmdFcn
host="localhost"
user=NA
verbose=FALSE
R="R"

source('~/GitHub_Miscellaneous/PEcAn/refresh.pecan.R')
refresh.pecan()

head(PEcAn.data.atmosphere::metgapfill,20)

library(PEcAn.all)



##########################################################################
require(RPostgreSQL)
driver   <- "PostgreSQL"
user     <- bety$user
dbname   <- bety$dbname
password <- bety$password
bety.host<- bety$host
username <- ""
dbparms <- list(driver=driver, user=user, dbname=dbname, password=password, host=bety.host)
con       <- db.open(dbparms)

met <- input$met$type
if(input$met$id==""){
  download=TRUE
}else{
  download=FALSE
  raw.id=input$met$id
}

regional <- met == "NARR" # Either regional or site run
new.site = as.numeric(site$id)
str_ns    <- paste0(new.site %/% 1000000000, "-", new.site %% 1000000000)


input.id <- 1000000173
outfolder <- "/fs/data1/pecan.data/input/Ameriflux_CF_site_0-772"
formatname <- 'CF Meteorology'
mimetype <- 'application/x-netcdf'
site.id <- siteid <- 772
start_date <- startdate <- "1998-01-01 00:00:00"
end_date   <- enddate  <- "2012-12-31 00:00:00"
pkg <- "PEcAn.data.atmosphere"
fcn <- "met2CF.Ameriflux"
username <- ""
con=con
hostname='localhost'
write=TRUE

=site.id

cf.id <- convert.input(input.id,outfolder,formatname,mimetype,site.id=site$id,start_date,end_date,pkg,fcn,
                       username,con=con,hostname=host$name,write=TRUE) 
##################################

in.path <- "/fs/data1/pecan.data/input/Ameriflux_CF_gapfill_site_0-772"
in.prefix <- "US-NR1"   
outfolder <- "/fs/data1/pecan.data/input/Ameriflux_SIPNET_site_0-772"  
start_date <- "1998-01-01 00:00:00" 
end_date <-  "2012-12-31 00:00:00"
overwrite=FALSE
verbose=FALSE










########################################################################
#convert input variables for extraction

site.id=site$id
hostname=host$name
write=TRUE
l <- list(slat=new.lat,slon=new.lon,newsite=new.site)

# extract variables

in.path <-  "/fs/data4/NARR_CF_Permute/"
in.prefix <- "NARR" 
outfolder <- "/fs/data4/NARR_CF_site_0-772/" 
startdate <- "1979-01-01 00:00:00"                
enddate <- "2013-12-31 00:00:00"
slat <- "slat = 40.0329"
slon <- "slon = -105.546"
newsite <- "newsite = 772" 

# convert input variables for model

input.id=ready.id
site.id=site$id
hostname=host$name
write = TRUE
l <- list(lst=lst,overwrite=overwrite)

# DALEC

in.path <- "/fs/data4/NARR_CF_site_0-772/"
in.prefix <- "NARR"
outfolder <- "/fs/data4/NARR_DALEC_site_0-772/"
start_date <- "1979-01-01 00:00:00"
end_date <- "2013-12-31 00:00:00"
lst <- lst
overwrite=FALSE
verbose=TRUE




# ED2

"PEcAn.ED2::met2model.ED2('/fs/data4/NARR_CF_site_0-772/','NARR','/fs/data4/NARR_ED2_site_0-772/','1979-01-01 00:00:00','2013-12-31 00:00:00','lst = -7','overwrite = ')"


in.path <- "/fs/data4/NARR_CF_site_0-772/"
in.prefix <- "NARR"
outfolder <- "/fs/data4/NARR_ED2_site_0-772/"
start_date <- "1979-01-01 00:00:00"
end_date <- "2013-12-31 00:00:00"
lst <- lst
overwrite=FALSE
verbose=TRUE





"PEcAn.LINKAGES::met2model.LINKAGES('/fs/data1/pecan.data/input/Ameriflux_CF_gapfill_site_0-755','US-Dk2','/fs/data1/pecan.data/input/Ameriflux_LINKAGES_site_0-755/','2006-01-01 00:00:00','2007-12-31 00:00:00',lst = -5)"


in.path <- '/fs/data1/pecan.data/input/Ameriflux_CF_gapfill_site_0-755'
in.prefix <- 'US-Dk2'
outfolder <- '/fs/data1/pecan.data/input/Ameriflux_LINKAGES_site_0-755/'
start_date <- "2006-01-01 00:00:00"
end_date <- "2007-12-31 00:00:00"
lst <- lst
overwrite=FALSE
verbose=TRUE

#########################################


in.path=dirname(result$file[1])
in.prefix=in.prefix
siteid = siteid
startdate = paste(input$start_date)
enddate = paste(input$end_date)
mimetype
formatname
parentid = input$id
con = con
hostname = machine$hostname


##################################################################################


site = 'US-Dk2'
outfolder = '/fs/data1/pecan.data/input/Ameriflux_site_0-755'
start_date = '2006-01-01 00:00:00'
end_date = '2007-12-31 00:00:00'
bd.host = 'http://dap.ncsa.illinois.edu:8184/convert/'







