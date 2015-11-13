##' Instructions:
##' 
##' USE ON A PECAN SERVER 
##' 
##' 1. Update the xml file with your info - you won't be using this xml to actually
##'     do runs though so don't worry about things not related to met. 
##'     Make sure the site and date info for the met are correct in the xml file. 
##'     They need to be EXACTLY the same as in the database. 
##'     You can see the two examples I have up already. 
##' 
##' 2. Load the xml using the below script. 
##'     The variables below are the only ones that you actually need from the xml
##'     for the met workflow so if you decide you don't want to use the xml, 
##'     you can edit them directly. (Note that some of them are lists.)
##' 
##' 3. Switch over to the met workflow and run line by line. You could also call
##'     the whole function 
##'     PalEON.met.process(site, input_met, start_date, end_date, model, host, dbparms, dir, browndog=NULL)
##'     but when you go through it line by line it'll be easier to debug. 
##'     
##' 4. Check that the met is entered right in the database
##'     - Inputs table
##'     - Dbfiles table
##'    And that the files look good in on the server (/fs/data1/pecan.data/input/...)
##'    
##' 5. Check to see that the sites show up on the map at test-pecan.bu.edu/pecan_user
##' 
##' 6. Party.
##' 

rm(list = setdiff(ls(), lsf.str()))  # clear variables but not sourced functions
for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections

require(PEcAn.all)
# PEcAn.data.atmosphere::

xml_file <- "PalEON.pecan.xml"
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