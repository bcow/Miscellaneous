load("~/GitHub_Miscellaneous/FACE/FACE_CDIAC_obvs.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_LB_summary.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_years.Rdata")

par(mfrow = c(3,2))

a <- which(DUKE_obvs$CO2 == "amb")
e <- which(DUKE_obvs$CO2 == "elev")
sort_yrs <- sort(unique(DUKE_obvs$YEAR[a]), index.return=TRUE)
obv_yrs <- sort_yrs$x
obv_avg <- tapply(DUKE_obvs$LITTER.PROD[a], mean, INDEX = DUKE_obvs$YEAR[a])[sort_yrs$ix]

plot(obv_avg, type="l")
title("DUKE A")
plot(DUKE_a_LB_Y_mean[which(obv_yrs %in% year_96_07)], type = "l")


##

a <- which(RHIN_obvs$CO2 == "amb")
e <- which(RHIN_obvs$CO2 == "elev")
sort_yrs <- sort(unique(RHIN_obvs$YEAR[a]), index.return=TRUE)
obv_yrs <- sort_yrs$x
obv_avg <- tapply(RHIN_obvs$LITTER.PROD[a], mean, INDEX = RHIN_obvs$YEAR[a])[sort_yrs$ix]

plot(obv_avg,type="l")
title("RHIN A")
plot(RHIN_a_LB_Y_mean[which(obv_yrs %in% year_96_07)] ,type = "l")

##

a <- which(ORNL_obvs$CO2 == "amb")
e <- which(ORNL_obvs$CO2 == "elev")
sort_yrs <- sort(unique(ORNL_obvs$YEAR[a]), index.return=TRUE)
obv_yrs <- sort_yrs$x
obv_avg <- tapply(ORNL_obvs$LITTER.PROD[a], mean, INDEX = ORNL_obvs$YEAR[a])[sort_yrs$ix]

plot(obv_avg, type ="l")
title("ORNL A")
plot(ORNL_a_LB_Y_mean[which(obv_yrs %in% year_96_07)],type ="l" )

#########################################################################
#########################################################################
#########################################################################

a <- which(DUKE_obvs$CO2 == "amb")
e <- which(DUKE_obvs$CO2 == "elev")
sort_yrs <- sort(unique(DUKE_obvs$YEAR[e]), index.return=TRUE)
obv_yrs <- sort_yrs$x
obv_avg <- tapply(DUKE_obvs$LITTER.PROD[e], mean, INDEX = DUKE_obvs$YEAR[e])[sort_yrs$ix]

plot(obv_avg, type="l")
title("DUKE E")
plot(DUKE_e_LB_Y_mean[which(obv_yrs %in% year_96_07)], type = "l")


##

a <- which(RHIN_obvs$CO2 == "amb")
e <- which(RHIN_obvs$CO2 == "elev")
sort_yrs <- sort(unique(RHIN_obvs$YEAR[e]), index.return=TRUE)
obv_yrs <- sort_yrs$x
obv_avg <- tapply(RHIN_obvs$LITTER.PROD[e], mean, INDEX = RHIN_obvs$YEAR[e])[sort_yrs$ix]

plot(obv_avg,type="l")
title("RHIN E")
plot(RHIN_e_LB_Y_mean[which(obv_yrs %in% year_96_07)] ,type = "l")

##

a <- which(ORNL_obvs$CO2 == "amb")
e <- which(ORNL_obvs$CO2 == "elev")
sort_yrs <- sort(unique(ORNL_obvs$YEAR[e]), index.return=TRUE)
obv_yrs <- sort_yrs$x
obv_avg <- tapply(ORNL_obvs$LITTER.PROD[e], mean, INDEX = ORNL_obvs$YEAR[e])[sort_yrs$ix]

plot(obv_avg, type ="l")
title("ORNL E")
plot(ORNL_e_LB_Y_mean[which(obv_yrs %in% year_96_07)],type ="l" )
