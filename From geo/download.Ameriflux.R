download.Ameriflux <- function(outfolder,start_year,end_year){
  
  if(!file.exists(outfolder)) dir.create(outfolder)
  
  setwd(outfolder)
  
  start_year <- as.numeric(start_year)
  end_year   <- as.numeric(end_year)
  
    for (year in seq(end_year,start_year,by=-1)){
      system(paste0("wget -c ftp://cdiac.ornl.gov/pub/ameriflux/data/Level2/Sites_ByID/US-Ha1/with_gaps/AMF_USHa1_",year,"_L2_WG_V008.nc"))
      file.rename(paste0("AMF_USHa1_",year,"_L2_WG_V008.nc"), paste0("Ameriflux_USHa1_",year,".nc"))
    }    
} 
