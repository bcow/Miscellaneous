# PalEON.met.test.R

# rm(list = setdiff(ls(), lsf.str()))  # clear variables but not sourced functions
# for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections

  require(PEcAn.all)
  source("PalEON/PalEON.met.process.R")
  
  require(PEcAn.all)
  settings <- xmlToList(xmlParse("PalEON//PalEON.pecan.xml"))
  
  site       = settings$run$site 
  input_met  = settings$run$inputs$met
  start_date = settings$run$start.date 
  end_date   = settings$run$end.date
  model      = settings$model$type
  host       = settings$run$host
  dbparms    = settings$database$bety 
  dir        = settings$run$dbfiles
  browndog   = settings$browndog
  
#   results <- PalEON.met.process(site, input_met, start_date, end_date, model, host, dbparms, dir, browndog=NULL) 


