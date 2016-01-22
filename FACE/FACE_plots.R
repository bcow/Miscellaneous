load("~/GitHub_Miscellaneous/FACE/FACE_CDIAC_obvs.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_summary.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_years.Rdata")
#############

par(mfrow = c(2,3))

a <- which(DUKE_obvs$CO2 == "amb")
e <- which(DUKE_obvs$CO2 == "elev")
plot(DUKE_obvs$YEAR[a], DUKE_obvs$NPP[a], col="blue", xlim = c(1996,2007), ylim = c(min(DUKE_obvs$NPP[a]), max(DUKE_obvs$NPP[e])))
lines(unique(DUKE_obvs$YEAR[a]),tapply(DUKE_obvs$NPP[a], mean, INDEX = DUKE_obvs$YEAR[a]), col="blue")
points(DUKE_obvs$YEAR[e], DUKE_obvs$NPP[e], col="red")
lines(unique(DUKE_obvs$YEAR[e]),tapply(DUKE_obvs$NPP[e], mean, INDEX = DUKE_obvs$YEAR[e]), col="red")


title("DUKE")

a <- which(ORNL_obvs$CO2 == "amb")
e <- which(ORNL_obvs$CO2 == "elev")
plot(ORNL_obvs$YEAR[a], ORNL_obvs$NPP[a], col="blue", xlim = c(1998,2008), ylim = c(min(ORNL_obvs$NPP[a]), max(ORNL_obvs$NPP[e])))
lines(unique(ORNL_obvs$YEAR[a]),tapply(ORNL_obvs$NPP[a], mean, INDEX = ORNL_obvs$YEAR[a]), col="blue")
points(ORNL_obvs$YEAR[e], ORNL_obvs$NPP[e], col="red")
lines(unique(ORNL_obvs$YEAR[e]),tapply(ORNL_obvs$NPP[e], mean, INDEX = ORNL_obvs$YEAR[e]), col="red")

title("ORNL")




sort_yrs <- sort(RHIN_obvs$YEAR, index.return=TRUE)
RHIN_obvs$YEAR <- RHIN_obvs$YEAR[sort_yrs$ix]
RHIN_obvs$NPP  <- RHIN_obvs$NPP[sort_yrs$ix]
RHIN_obvs$CO2  <- RHIN_obvs$CO2[sort_yrs$ix]

a <- which(RHIN_obvs$CO2 == "amb")
e <- which(RHIN_obvs$CO2 == "elev")

plot(RHIN_obvs$YEAR[a], RHIN_obvs$NPP[a], col="blue", xlim = c(1998,2008), ylim = c(min(RHIN_obvs$NPP[a]), max(RHIN_obvs$NPP[e])))
lines(unique(RHIN_obvs$YEAR[a]),tapply(RHIN_obvs$NPP[a], mean, INDEX = RHIN_obvs$YEAR[a]), col="blue")
points(RHIN_obvs$YEAR[e], RHIN_obvs$NPP[e], col="red")
lines(unique(RHIN_obvs$YEAR[e]),tapply(RHIN_obvs$NPP[e], mean, INDEX = RHIN_obvs$YEAR[e]), col="red")

title("RHIN")


#------------------------------------------------#

yrs <- unique(year_96_07)
plot(yrs, DUKE_e_NPP_Y_mean, type="l",ylim = c(min(DUKE_a_NPP_Y_lw), max(DUKE_e_NPP_Y_up)), col="red", lwd=3)
lines(yrs, DUKE_a_NPP_Y_mean, col="blue", lwd=3)

lines(yrs, DUKE_e_NPP_Y_up, lty=2, col="red")
lines(yrs, DUKE_e_NPP_Y_lw, lty=2, col="red")

lines(yrs, DUKE_a_NPP_Y_up, lty=2, col="blue")
lines(yrs, DUKE_a_NPP_Y_lw, lty=2, col="blue")

#------------------------------------------------#

yrs <- unique(year_98_08)
plot(yrs, ORNL_e_NPP_Y_mean, type="l",ylim = c(min(ORNL_a_NPP_Y_lw), max(ORNL_e_NPP_Y_up)), col="red", lwd=3)
lines(yrs, ORNL_a_NPP_Y_mean, col="blue", lwd=3)

lines(yrs, ORNL_e_NPP_Y_up, lty=2, col="red")
lines(yrs, ORNL_e_NPP_Y_lw, lty=2, col="red")

lines(yrs, ORNL_a_NPP_Y_up, lty=2, col="blue")
lines(yrs, ORNL_a_NPP_Y_lw, lty=2, col="blue")

#------------------------------------------------#

yrs <- unique(year_98_08)
plot(yrs, RHIN_e_NPP_Y_mean, type="l",ylim = c(min(RHIN_a_NPP_Y_lw), max(RHIN_e_NPP_Y_up)), col="red", lwd=3)
lines(yrs, RHIN_a_NPP_Y_mean, col="blue", lwd=3)

lines(yrs, RHIN_e_NPP_Y_up, lty=2, col="red")
lines(yrs, RHIN_e_NPP_Y_lw, lty=2, col="red")

lines(yrs, RHIN_a_NPP_Y_up, lty=2, col="blue")
lines(yrs, RHIN_a_NPP_Y_lw, lty=2, col="blue")


