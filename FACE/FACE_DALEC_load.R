require(ncdf4)
require(ncdf4.helpers)


year_98_08 <- c(
  rep(1998,365),
  rep(1999,365),
  rep(2000,366),
  rep(2001,365),
  rep(2002,365),
  rep(2003,365),
  rep(2004,366),
  rep(2005,365),
  rep(2006,365),
  rep(2007,365),
  rep(2008,366)  
)

year_96_07 <- c(
  rep(1996,366),
  rep(1997,365),
  rep(1998,365),
  rep(1999,365),
  rep(2000,366),
  rep(2001,365),
  rep(2002,365),
  rep(2003,365),
  rep(2004,366),
  rep(2005,365),
  rep(2006,365),
  rep(2007,365)
)

save(year_96_07,year_96_07, file="~/GitHub_Miscellaneous/FACE/FACE_years.Rdata")

par(mfrow=c(1,3))

convert <- 86400/.001

###################################################################################################
###################################################################################################
# DUKE 

year <- year_96_07
length(year)

WFID <- 1000000959 #AMBIENT

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
npp <- ncvar_get(nc,"NPP")
#plot(npp, type="l")
length(npp)

NPP <- matrix(NA, nrow=length(runs), ncol=length(npp))
NPP_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  npp <- ncvar_get(nc,"NPP")
  print(i)
  print(length(npp))
  NPP[i,] <- c(npp, rep(NA, length(year)-length(npp)))
  NPP_Y[i,] <- tapply(NPP[i,], FUN=mean, INDEX=year)
  NPP_Y[i,] <- NPP_Y[i,]*convert
  # lines(npp,col=i+1)
  nc_close(nc)
}

nc.get.variable.list(nc)

max_NPP_Y <- apply(NPP_Y, 2, max)
up_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .975, na.rm = TRUE))
mean_NPP_Y <- colMeans(NPP_Y, na.rm = TRUE)
lw_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .025, na.rm = TRUE))
min_NPP_Y <- apply(NPP_Y, 2, min)

yrs <- unique(year)

# plot(yrs, up_NPP_Y, type = "l", ylim = c(min(lw_NPP_Y), max(up_NPP_Y)), col = "red", lty=2)
# lines(yrs,lw_NPP_Y, col = "red", lty=2)
# lines(yrs,mean_NPP_Y, lwd=3)

DUKE_a_NPP_Y_up <- up_NPP_Y 
DUKE_a_NPP_Y_mean <- mean_NPP_Y
DUKE_a_NPP_Y_lw <- lw_NPP_Y 

#-----------------------------------#

WFID <- 1000000960 #ELEVATED

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
npp <- ncvar_get(nc,"NPP")
#plot(npp, type="l")
length(npp)

NPP <- matrix(NA, nrow=length(runs), ncol=length(npp))
NPP_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  npp <- ncvar_get(nc,"NPP")
  print(i)
  print(length(npp))
  NPP[i,] <- c(npp, rep(NA, length(year)-length(npp)))
  NPP_Y[i,] <- tapply(NPP[i,], FUN=mean, INDEX=year)
  NPP_Y[i,] <- NPP_Y[i,]*3000*86400/.001
  # lines(npp,col=i+1)
  nc_close(nc)
}

nc.get.variable.list(nc)

max_NPP_Y <- apply(NPP_Y, 2, max)
up_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .975, na.rm = TRUE))
mean_NPP_Y <- colMeans(NPP_Y, na.rm = TRUE)
lw_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .025, na.rm = TRUE))
min_NPP_Y <- apply(NPP_Y, 2, min)

yrs <- unique(year)

# plot(yrs, up_NPP_Y, type = "l", ylim = c(min(lw_NPP_Y), max(up_NPP_Y)), col = "red", lty=2)
# lines(yrs,lw_NPP_Y, col = "red", lty=2)
# lines(yrs,mean_NPP_Y, lwd=3)

DUKE_e_NPP_Y_up <- up_NPP_Y 
DUKE_e_NPP_Y_mean <- mean_NPP_Y
DUKE_e_NPP_Y_lw <- lw_NPP_Y 

###################################################################################################
###################################################################################################
# ORNL 

year <- year_98_08
length(year)

WFID <- 1000000954 #AMBIENT

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
npp <- ncvar_get(nc,"NPP")
length(npp)

NPP <- matrix(NA, nrow=length(runs), ncol=length(npp))
NPP_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  npp <- ncvar_get(nc,"NPP")
  print(i)
  print(length(npp))
  NPP[i,] <- c(npp, rep(NA, length(year)-length(npp)))
  NPP_Y[i,] <- tapply(NPP[i,], FUN=mean, INDEX=year)
  NPP_Y[i,] <- NPP_Y[i,]*3000*86400/.001
  # lines(npp,col=i+1)
  nc_close(nc)
}

nc.get.variable.list(nc)

max_NPP_Y <- apply(NPP_Y, 2, max)
up_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .975, na.rm = TRUE))
mean_NPP_Y <- colMeans(NPP_Y, na.rm = TRUE)
lw_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .025, na.rm = TRUE))
min_NPP_Y <- apply(NPP_Y, 2, min)

yrs <- unique(year)

# plot(yrs, up_NPP_Y, type = "l", ylim = c(min(lw_NPP_Y), max(up_NPP_Y)), col = "red", lty=2)
# lines(yrs,lw_NPP_Y, col = "red", lty=2)
# lines(yrs,mean_NPP_Y, lwd=3)

ORNL_a_NPP_Y_up <- up_NPP_Y 
ORNL_a_NPP_Y_mean <- mean_NPP_Y
ORNL_a_NPP_Y_lw <- lw_NPP_Y 

#-----------------------------------#

WFID <- 1000000957 #ELEVATED

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
npp <- ncvar_get(nc,"NPP")
length(npp)

NPP <- matrix(NA, nrow=length(runs), ncol=length(npp))
NPP_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  npp <- ncvar_get(nc,"NPP")
  print(i)
  print(length(npp))
  NPP[i,] <- c(npp, rep(NA, length(year)-length(npp)))
  NPP_Y[i,] <- tapply(NPP[i,], FUN=mean, INDEX=year)
  NPP_Y[i,] <- NPP_Y[i,]*3000*86400/.001
  # lines(npp,col=i+1)
  nc_close(nc)
}

nc.get.variable.list(nc)

max_NPP_Y <- apply(NPP_Y, 2, max)
up_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .975, na.rm = TRUE))
mean_NPP_Y <- colMeans(NPP_Y, na.rm = TRUE)
lw_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .025, na.rm = TRUE))
min_NPP_Y <- apply(NPP_Y, 2, min)

yrs <- unique(year)

# plot(yrs, up_NPP_Y, type = "l", ylim = c(min(lw_NPP_Y), max(up_NPP_Y)), col = "red", lty=2)
# lines(yrs,lw_NPP_Y, col = "red", lty=2)
# lines(yrs,mean_NPP_Y, lwd=3)

ORNL_e_NPP_Y_up <- up_NPP_Y 
ORNL_e_NPP_Y_mean <- mean_NPP_Y
ORNL_e_NPP_Y_lw <- lw_NPP_Y 

###################################################################################################
###################################################################################################
# RHIN 

year <- year_98_08
length(year)

WFID <- 1000000955 #AMBIENT

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
npp <- ncvar_get(nc,"NPP")
length(npp)

NPP <- matrix(NA, nrow=length(runs), ncol=length(npp))
NPP_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  npp <- ncvar_get(nc,"NPP")
  print(i)
  print(length(npp))
  NPP[i,] <- c(npp, rep(NA, length(year)-length(npp)))
  NPP_Y[i,] <- tapply(NPP[i,], FUN=mean, INDEX=year)
  NPP_Y[i,] <- NPP_Y[i,]*3000*86400/.001
  # lines(npp,col=i+1)
  nc_close(nc)
}

nc.get.variable.list(nc)

max_NPP_Y <- apply(NPP_Y, 2, max)
up_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .975, na.rm = TRUE))
mean_NPP_Y <- colMeans(NPP_Y, na.rm = TRUE)
lw_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .025, na.rm = TRUE))
min_NPP_Y <- apply(NPP_Y, 2, min)

yrs <- unique(year)

# plot(yrs, up_NPP_Y, type = "l", ylim = c(min(lw_NPP_Y), max(up_NPP_Y)), col = "red", lty=2)
# lines(yrs,lw_NPP_Y, col = "red", lty=2)
# lines(yrs,mean_NPP_Y, lwd=3)

RHIN_a_NPP_Y_up <- up_NPP_Y 
RHIN_a_NPP_Y_mean <- mean_NPP_Y
RHIN_a_NPP_Y_lw <- lw_NPP_Y 

#-----------------------------------#

WFID <- 1000000956 #ELEVATED

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
npp <- ncvar_get(nc,"NPP")
length(npp)

NPP <- matrix(NA, nrow=length(runs), ncol=length(npp))
NPP_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  npp <- ncvar_get(nc,"NPP")
  print(i)
  print(length(npp))
  NPP[i,] <- c(npp, rep(NA, length(year)-length(npp)))
  NPP_Y[i,] <- tapply(NPP[i,], FUN=mean, INDEX=year)
  NPP_Y[i,] <- NPP_Y[i,]*3000*86400/.001
  # lines(npp,col=i+1)
  nc_close(nc)
}

nc.get.variable.list(nc)

max_NPP_Y <- apply(NPP_Y, 2, max)
up_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .975, na.rm = TRUE))
mean_NPP_Y <- colMeans(NPP_Y, na.rm = TRUE)
lw_NPP_Y <- apply(NPP_Y, 2, FUN = function(x) quantile(x, .025, na.rm = TRUE))
min_NPP_Y <- apply(NPP_Y, 2, min)

yrs <- unique(year)

# plot(yrs, up_NPP_Y, type = "l", ylim = c(min(lw_NPP_Y), max(up_NPP_Y)), col = "red", lty=2)
# lines(yrs,lw_NPP_Y, col = "red", lty=2)
# lines(yrs,mean_NPP_Y, lwd=3)

RHIN_e_NPP_Y_up <- up_NPP_Y 
RHIN_e_NPP_Y_mean <- mean_NPP_Y
RHIN_e_NPP_Y_lw <- lw_NPP_Y 




#####################################
# Save everyting to an .Rdata file 

save(DUKE_a_NPP_Y_up,DUKE_a_NPP_Y_mean,
     DUKE_a_NPP_Y_mean,
     DUKE_a_NPP_Y_lw,
     ORNL_a_NPP_Y_up,
     ORNL_a_NPP_Y_mean,
     ORNL_a_NPP_Y_lw,
     RHIN_a_NPP_Y_up,
     RHIN_a_NPP_Y_mean,
     RHIN_a_NPP_Y_lw,
     DUKE_e_NPP_Y_up,
     DUKE_e_NPP_Y_mean,
     DUKE_e_NPP_Y_lw,
     ORNL_e_NPP_Y_up,
     ORNL_e_NPP_Y_mean,
     ORNL_e_NPP_Y_lw,
     RHIN_e_NPP_Y_up,
     RHIN_e_NPP_Y_mean,
     RHIN_e_NPP_Y_lw, 
     file = "~/GitHub_Miscellaneous/FACE/FACE_NPP_summary.Rdata")
