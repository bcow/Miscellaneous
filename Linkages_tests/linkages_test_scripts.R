require(PEcAn.all)
require(PEcAn.LINKAGES)

########################################################################
## Setup settings

old.run <- "/fs/data2/output//PEcAn_1000000666/pecan.xml"
new.run <- "/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/linkages.pecan.xml"

#file.edit(old.run)
settings <- read.settings(old.run)


#clean.settings(inputfile=old.run, outputfile=new.run)
#file.edit(new.run)

settings <- read.settings("/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/linkages.pecan.xml")
settings <- xmlToList(xmlParse("/home/ecowdery/GitHub_Miscellaneous/Linkages_tests/linkages.pecan.xml"))
# Then pickup workflow at line 65

str(settings)

########################################################################
## Model to netcdf

outfolder <- "/home/ecowdery/Linkages2/Linkages/"


model2netcdf.LINKAGES(outfolder, 42.53, -72.18, '0850/01/01', '2010/12/31')


require(ncdf4)
require(ncdf4.helpers)

years <- seq(851,2010,by=2)

for(i in 1:length(years)){
    nc <- nc_open(sprintf("/fs/data2/output//PEcAn_1000000677/out/1000266376//%04d.nc", years[i] ))
  vars <- nc.get.variable.list(nc)
  for(v in vars){
    eval(parse(text = paste0(v,"[",i,"] <- ", ncvar_get(nc, v))))
  }
  nc_close(nc)
}

par(mfrow=c(3,2))
for(v in vars){
  plot(eval(parse(text = v)), main = v)
}

plot(NPP, main = "NPP")
plot(NEE, main = "NEE")
plot(TLB, main = "TLB")
plot(TSC, main = "TSC")











pfts <- settings$pfts
modeltype <-  settings$model$type
dbfiles <- settings$run$dbfiles
database <- settings$database$bety
forceupdate <- settings$meta.analysis$update
trait.names=NULL





########################################################################


in.path <- "/fs/data1/pecan.data/input/PalEON_CF_site_1-650/"
outfolder <- "/fs/data1/pecan.data/input/PalEON_LINKAGES_site_1-650"
in.prefix <- "PalEON"
start_date <- "0850-01-01 00:00:00"
end_date <- "2010-12-31 00:00:00"
overwrite=FALSE
verbose=FALSE

met2model.LINKAGES(in.path, in.prefix, outfolder, start_date, end_date, overwrite=FALSE,verbose=FALSE) 


model2netcdf.LINKAGES('/fs/data2/output//PEcAn_1000000665/out/1000265803', 42.53, -72.18, '0850/01/01', '2009/12/31')

########################################################################

outdir <- "/home/ecowdery/Linkages_tests/"
sitelat <- 42.53
sitelon <- 72.18
force=FALSE


model2netcdf.LINKAGES(outdir, sitelat, sitelon, start_date, end_date,force=FALSE, PFTs)
  


#################################
