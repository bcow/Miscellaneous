rm(list = setdiff(ls(), lsf.str()))  # clear variables but not sourced functions
for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections

require(PEcAn.all)
# PEcAn.data.atmosphere::

xml_file <- "/home/ecowdery/GitHub_Miscellaneous/PalEON/PalEON.pecan.xml"
# settings <- read.settings(xml_file) 
settings <- xmlToList(xmlParse(xml_file))

site       = settings$run$site 
input_met  = settings$run$inputs$met
start_date = settings$run$start.date 
end_date   = settings$run$end.date
model      = settings$model$type
host       = settings$run$host
dbparms    = settings$database$bety 
dir        = settings$run$dbfiles
browndog   = settings$browndog

stage$met2model = TRUE
ready.id <- 1000000478

input.id = ready.id
site.id=site$id
con=con
hostname=host$name
write=TRUE
lst=lst
lat=new.site$lat
lon=new.site$lon

l <- list(lst=lst,
          lat=new.site$lat,
          lon=new.site$lon)


in.path <- "/fs/data1/pecan.data/input/PalEON_CF_site_1-650"
in.prefix <- "PalEON"
outfolder <- "//fs/data1/pecan.data/input/PalEON_LINKAGES_site_1-650/"
overwrite=FALSE
verbose=FALSE

