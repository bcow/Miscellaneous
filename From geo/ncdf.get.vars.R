ncdf.get.vars <- function(con,dbparams,data.host,filename, ...){
  vars <- list(...)
  
  #filename <- "/home/ecowdery/test_FACE/RHIN/FACE.RHIN_forcing_h.nc"
  #vars <- list("YEAR","DOY")
  
  n <- length(vars)
  if (n==0){print("No variables specified"); Return(NULL)}
  
  require(ncdf4)
  require(ncdf4.helpers)
  
  outstr <- ""
  
  for i in 1:n{
    vname <- vars[[i]]
    
    nc  <- nc_open(filename)
    vdata <- as.vector(ncvar_get(nc,vname))
    outstr <- paste(outstr,vname, "=", dput(vdata));
    
  }
  
}
