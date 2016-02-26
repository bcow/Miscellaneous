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

save(year_98_08,year_96_07, file="~/GitHub_Miscellaneous/FACE/FACE_years.Rdata")

par(mfrow=c(3,2))

SLA <- 0.0345681501079525

###################################################################################################
###################################################################################################
# DUKE 

year <- year_96_07
length(year)

WFID <- 1000000959 #AMBIENT

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
LitterBiomass <- ncvar_get(nc,"LitterBiomass")
nc.get.variable.list(nc)
length(LitterBiomass)

LB <- matrix(NA, nrow=length(runs), ncol=length(LitterBiomass))
LB_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

# par(mfrow = c(1,1))
# plot(LitterBiomass, type ="l")


bad = c()

for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  LitterBiomass <- ncvar_get(nc,"LitterBiomass")
  print(i)
  print(length(LitterBiomass))
  LB[i,] <- c(LitterBiomass, rep(NA, length(year)-length(LitterBiomass)))
  LB_Y[i,] <- tapply(LB[i,], FUN=mean, INDEX=year)
#   lines(LitterBiomass,col=i+1)
  if(sum(LitterBiomass > 1)){bad <- c(bad,i)}
  nc_close(nc)
}
LB <- LB[-bad,]
LB_Y <- LB_Y[-bad,]



max_LB_Y <- apply(LB_Y, 2, max)
up_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .95, na.rm = TRUE))
mean_LB_Y <- colMeans(LB_Y, na.rm = TRUE)
lw_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .05, na.rm = TRUE))
min_LB_Y <- apply(LB_Y, 2, min)

yrs <- unique(year)

plot(yrs, up_LB_Y, type = "l", ylim = c(min(lw_LB_Y), max(up_LB_Y)), col = "red", lty=2)
lines(yrs,lw_LB_Y, col = "red", lty=2)
lines(yrs,mean_LB_Y, lwd=3)
title("DUKE AMBIENT")

DUKE_a_LB_Y_up <- up_LB_Y 
DUKE_a_LB_Y_mean <- mean_LB_Y
DUKE_a_LB_Y_lw <- lw_LB_Y 

#-----------------------------------#

WFID <- 1000000960 #ELEVATED


runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
LitterBiomass <- ncvar_get(nc,"LitterBiomass")
length(LitterBiomass)

LB <- matrix(NA, nrow=length(runs), ncol=length(LitterBiomass))
LB_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

bad <- c()
for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  LitterBiomass <- ncvar_get(nc,"LitterBiomass")
  print(i)
  print(length(LitterBiomass))
  LB[i,] <- c(LitterBiomass, rep(NA, length(year)-length(LitterBiomass)))
  LB_Y[i,] <- tapply(LB[i,], FUN=mean, INDEX=year)
  #   lines(LitterBiomass,col=i+1)
  if(sum(LitterBiomass > 1)){bad <- c(bad,i)}
  nc_close(nc)
}
LB <- LB[-bad,]
LB_Y <- LB_Y[-bad,]

max_LB_Y <- apply(LB_Y, 2, max)
up_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .95, na.rm = TRUE))
mean_LB_Y <- colMeans(LB_Y, na.rm = TRUE)
lw_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .05, na.rm = TRUE))
min_LB_Y <- apply(LB_Y, 2, min)

yrs <- unique(year)

plot(yrs, up_LB_Y, type = "l", ylim = c(min(lw_LB_Y), max(up_LB_Y)), col = "red", lty=2)
lines(yrs,lw_LB_Y, col = "red", lty=2)
lines(yrs,mean_LB_Y, lwd=3)
title("DUKE ELEVATED")


DUKE_e_LB_Y_up <- up_LB_Y 
DUKE_e_LB_Y_mean <- mean_LB_Y
DUKE_e_LB_Y_lw <- lw_LB_Y 

###################################################################################################
###################################################################################################
# ORNL 

year <- year_98_08
length(year)

WFID <- 1000000954 #AMBIENT

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
LitterBiomass <- ncvar_get(nc,"LitterBiomass")
length(LitterBiomass)

LB <- matrix(NA, nrow=length(runs), ncol=length(LitterBiomass))
LB_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

bad <- c()
for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  LitterBiomass <- ncvar_get(nc,"LitterBiomass")
  print(i)
  print(length(LitterBiomass))
  LB[i,] <- c(LitterBiomass, rep(NA, length(year)-length(LitterBiomass)))
  LB_Y[i,] <- tapply(LB[i,], FUN=mean, INDEX=year)
  #   lines(LitterBiomass,col=i+1)
  if(sum(LitterBiomass > 1)){bad <- c(bad,i)}
  nc_close(nc)
}
LB <- LB[-bad,]
LB_Y <- LB_Y[-bad,]

max_LB_Y <- apply(LB_Y, 2, max)
up_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .95, na.rm = TRUE))
mean_LB_Y <- colMeans(LB_Y, na.rm = TRUE)
lw_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .05, na.rm = TRUE))
min_LB_Y <- apply(LB_Y, 2, min)

yrs <- unique(year)

plot(yrs, up_LB_Y, type = "l", ylim = c(min(lw_LB_Y), max(up_LB_Y)), col = "red", lty=2)
lines(yrs,lw_LB_Y, col = "red", lty=2)
lines(yrs,mean_LB_Y, lwd=3)
title("ORNL AMBIENT")


ORNL_a_LB_Y_up <- up_LB_Y 
ORNL_a_LB_Y_mean <- mean_LB_Y
ORNL_a_LB_Y_lw <- lw_LB_Y 

#-----------------------------------#

WFID <- 1000000957 #ELEVATED

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
LitterBiomass <- ncvar_get(nc,"LitterBiomass")
length(LitterBiomass)

LB <- matrix(NA, nrow=length(runs), ncol=length(LitterBiomass))
LB_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

bad <- c()
for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  LitterBiomass <- ncvar_get(nc,"LitterBiomass")
  print(i)
  print(length(LitterBiomass))
  LB[i,] <- c(LitterBiomass, rep(NA, length(year)-length(LitterBiomass)))
  LB_Y[i,] <- tapply(LB[i,], FUN=mean, INDEX=year)
  #   lines(LitterBiomass,col=i+1)
  if(sum(LitterBiomass > 1)){bad <- c(bad,i)}
  nc_close(nc)
}
LB <- LB[-bad,]
LB_Y <- LB_Y[-bad,]

nc.get.variable.list(nc)

max_LB_Y <- apply(LB_Y, 2, max)
up_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .95, na.rm = TRUE))
mean_LB_Y <- colMeans(LB_Y, na.rm = TRUE)
lw_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .05, na.rm = TRUE))
min_LB_Y <- apply(LB_Y, 2, min)

yrs <- unique(year)

plot(yrs, up_LB_Y, type = "l", ylim = c(min(lw_LB_Y), max(up_LB_Y)), col = "red", lty=2)
lines(yrs,lw_LB_Y, col = "red", lty=2)
lines(yrs,mean_LB_Y, lwd=3)
title("ORNL ELEVATED")

ORNL_e_LB_Y_up <- up_LB_Y 
ORNL_e_LB_Y_mean <- mean_LB_Y
ORNL_e_LB_Y_lw <- lw_LB_Y 

###################################################################################################
###################################################################################################
# RHIN 

year <- year_98_08
length(year)

WFID <- 1000000955 #AMBIENT

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
LitterBiomass <- ncvar_get(nc,"LitterBiomass")
length(LitterBiomass)

LB <- matrix(NA, nrow=length(runs), ncol=length(LitterBiomass))
LB_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

bad <- c()
for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  LitterBiomass <- ncvar_get(nc,"LitterBiomass")
  print(i)
  print(length(LitterBiomass))
  LB[i,] <- c(LitterBiomass, rep(NA, length(year)-length(LitterBiomass)))
  LB_Y[i,] <- tapply(LB[i,], FUN=mean, INDEX=year)
  #   lines(LitterBiomass,col=i+1)
  if(sum(LitterBiomass > 1)){bad <- c(bad,i)}
  nc_close(nc)
}
LB <- LB[-bad,]
LB_Y <- LB_Y[-bad,]

nc.get.variable.list(nc)

max_LB_Y <- apply(LB_Y, 2, max)
up_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .95, na.rm = TRUE))
mean_LB_Y <- colMeans(LB_Y, na.rm = TRUE)
lw_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .05, na.rm = TRUE))
min_LB_Y <- apply(LB_Y, 2, min)

yrs <- unique(year)

plot(yrs, up_LB_Y, type = "l", ylim = c(min(lw_LB_Y), max(up_LB_Y)), col = "red", lty=2)
lines(yrs,lw_LB_Y, col = "red", lty=2)
lines(yrs,mean_LB_Y, lwd=3)
title("RHIN AMBIENT")

RHIN_a_LB_Y_up <- up_LB_Y 
RHIN_a_LB_Y_mean <- mean_LB_Y
RHIN_a_LB_Y_lw <- lw_LB_Y 

#-----------------------------------#

WFID <- 1000000956 #ELEVATED

runs <- dir(paste0("/fs/data2/output/PEcAn_",WFID,"/out/"), full.names=TRUE)
nc <- nc_open(file.path(runs[1],"2004.nc"))
LitterBiomass <- ncvar_get(nc,"LitterBiomass")
length(LitterBiomass)

LB <- matrix(NA, nrow=length(runs), ncol=length(LitterBiomass))
LB_Y <- matrix(NA, nrow=length(runs), ncol=length(unique(year)))

bad <- c()
for(i in 1:length(runs)){
  nc <- nc_open(file.path(runs[i],"2004.nc"))
  LitterBiomass <- ncvar_get(nc,"LitterBiomass")
  print(i)
  print(length(LitterBiomass))
  LB[i,] <- c(LitterBiomass, rep(NA, length(year)-length(LitterBiomass)))
  LB_Y[i,] <- tapply(LB[i,], FUN=mean, INDEX=year)
  #   lines(LitterBiomass,col=i+1)
  if(sum(LitterBiomass > 1)){bad <- c(bad,i)}
  nc_close(nc)
}
LB <- LB[-bad,]
LB_Y <- LB_Y[-bad,]
nc.get.variable.list(nc)

max_LB_Y <- apply(LB_Y, 2, max)
up_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .95, na.rm = TRUE))
mean_LB_Y <- colMeans(LB_Y, na.rm = TRUE)
lw_LB_Y <- apply(LB_Y, 2, FUN = function(x) quantile(x, .05, na.rm = TRUE))
min_LB_Y <- apply(LB_Y, 2, min)

yrs <- unique(year)

plot(yrs, up_LB_Y, type = "l", ylim = c(min(lw_LB_Y), max(up_LB_Y)), col = "red", lty=2)
lines(yrs,lw_LB_Y, col = "red", lty=2)
lines(yrs,mean_LB_Y, lwd=3)
title("RHIN ELEVATED")

RHIN_e_LB_Y_up <- up_LB_Y 
RHIN_e_LB_Y_mean <- mean_LB_Y
RHIN_e_LB_Y_lw <- lw_LB_Y 




#####################################
# Save everyting to an .Rdata file 

save(DUKE_a_LB_Y_up,DUKE_a_LB_Y_mean,
     DUKE_a_LB_Y_mean,
     DUKE_a_LB_Y_lw,
     ORNL_a_LB_Y_up,
     ORNL_a_LB_Y_mean,
     ORNL_a_LB_Y_lw,
     RHIN_a_LB_Y_up,
     RHIN_a_LB_Y_mean,
     RHIN_a_LB_Y_lw,
     DUKE_e_LB_Y_up,
     DUKE_e_LB_Y_mean,
     DUKE_e_LB_Y_lw,
     ORNL_e_LB_Y_up,
     ORNL_e_LB_Y_mean,
     ORNL_e_LB_Y_lw,
     RHIN_e_LB_Y_up,
     RHIN_e_LB_Y_mean,
     RHIN_e_LB_Y_lw, 
     file = "~/GitHub_Miscellaneous/FACE/FACE_LB_summary.Rdata")
