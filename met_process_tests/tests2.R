in.path <- "/fs/data1/pecan.data/input/Ameriflux_CF_gapfill_site_0-772"
in.prefix <- "US-NR1"                                                    
outfolder <- "/fs/data1/pecan.data/input/Ameriflux_DALEC_site_0-772/"   
start_date <- "1999-01-01 00:00:00"                                       
end_date <- "2012-12-31 00:00:00" 


l <- list(...)

require(PEcAn.DALEC)
met2model.DALEC(in.path, in.prefix, outfolder, start_date, end_date)

met2model.DALEC('/fs/data1/pecan.data/input/Ameriflux_CF_gapfill_site_0-772','US-NR1','/fs/data1/pecan.data/input/Ameriflux_DALEC_site_0-772/','1999-01-01 00:00:00','2012-12-31 00:00:00','lst = -7')


in.path <- "/fs/data1/pecan.data/input/Ameriflux_CF_gapfill_site_0-772" 
in.prefix <- "US-NR1"                                                    
outfolder <- "/fs/data1/pecan.data/input/Ameriflux_LINKAGES_site_0-772/"  
start_date <- "1999-01-01 00:00:00"                                       
end_date <- "2012-12-31 00:00:00"

source('~/pecan/models/linkages/R/met2model.LINKAGES.R')
result <- met2model.LINKAGES(in.path, in.prefix, outfolder, start_date, end_date)


, 
+                          "US-NR1", "/fs/data1/pecan.data/input/Ameriflux_ED2_site_0-772/", 
+                          "1999-01-01 00:00:00", "2012-12-31 00:00:00", "lst = -7"

in.path <- "/fs/data1/pecan.data/input/Ameriflux_CF_gapfill_site_0-772"
in.prefix <- "US-NR1"                                                    
outfolder <- "/fs/data1/pecan.data/input/Ameriflux_ED2_site_0-772/"  
start_date <- "1999-01-01 00:00:00"                                       
end_date <- "2012-12-31 00:00:00"
lst <- -7

source('~/pecan/models/ed/R/met2model.ED2.R')
result <- met2model.ED2(in.path, in.prefix, outfolder, start_date, end_date, lst)

