rm(list = setdiff(ls(), lsf.str()))  # clear variables but not sourced functions
for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections

require(PEcAn.all)

old_xml <- "/fs/data2/output/PEcAn_1000000376/pecan.xml"
new_xml <- "pecan.xml"

file.remove(new_xml)
clean.settings(old_xml,new_xml)
file.edit(new_xml)

###################################################################################

require(PEcAn.all)

file.edit("tests/online.pecan.test.xml")
new_xml <- "tests/online.pecan.test.xml"

new_xml <- "pecan.xml"
settings <- read.settings(new_xml)

site       = settings$run$site 
input_met  = settings$run$inputs$met
start_date = settings$run$start.date 
end_date   = settings$run$end.date
model      = settings$model$type
host       = settings$run$host
dbparms    = settings$database$bety 
dir        = settings$run$dbfiles
browndog   = settings$browndog

result <- met.process(site, input_met, start_date, end_date, model, host, dbparms, dir, browndog)

file.edit("tests/pecan2.tests.xml")
