require(PEcAn.data.atmosphere)

in.path <- "/projectnb/dietzelab/pecan.data/input/NARR_CF_site_0-339/"
in.prefix <- "NARR"
outfolder <- "/projectnb/dietzelab/pecan.data/input/NARR_ED2_site_0-339/"
lst <- -4
start_date <- "2014-01-01 00:00:00"
end_date <- "2014-12-31 23:59:00"


met2model.ED2(in.path,in.prefix,outfolder,lst=0,start_date, end_date, overwrite=FALSE,verbose=FALSE)
