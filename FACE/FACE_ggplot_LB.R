load("~/GitHub_Miscellaneous/FACE/FACE_CDIAC_obvs.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_LB_summary.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_years.Rdata")
#############

require(ggplot2)
require(gridExtra)



ORNL <- as.data.frame(cbind(
  ORNL_e_LB_Y_mean,
  ORNL_a_LB_Y_mean,
  ORNL_e_LB_Y_up,
  ORNL_e_LB_Y_lw,
  ORNL_a_LB_Y_up,
  ORNL_a_LB_Y_lw,
  yrs = unique(year_98_08)
))

h <- ggplot(ORNL, aes(x=yrs))

g1 <- h + geom_ribbon(aes(ymin=ORNL_a_LB_Y_lw, ymax=ORNL_a_LB_Y_up), alpha=.2, fill = "blue") + 
  geom_smooth(aes(y=ORNL_a_LB_Y_mean), colour = "darkblue", size =2, se=FALSE) + 
  geom_ribbon(aes(ymin=ORNL_e_LB_Y_lw, ymax=ORNL_e_LB_Y_up), alpha=.2, fill = "red") + 
  geom_smooth(aes(y=ORNL_e_LB_Y_mean), colour = "darkred", size =2, se=FALSE)+ 
#   ylim(0,3)+
  labs(
    x="Year",
    y="Litter Biomass kgC m2",
    title="ORNL"
  )+ theme_bw()+ theme(text = element_text(size=30)) + scale_x_continuous(breaks = seq(1997,2009, by=2))

RHIN <- as.data.frame(cbind(
  RHIN_e_LB_Y_mean,
  RHIN_a_LB_Y_mean,
  RHIN_e_LB_Y_up,
  RHIN_e_LB_Y_lw,
  RHIN_a_LB_Y_up,
  RHIN_a_LB_Y_lw,
  yrs = unique(year_98_08)
))

h <- ggplot(RHIN, aes(x=yrs))

g2 <- h + geom_ribbon(aes(ymin=RHIN_a_LB_Y_lw, ymax=RHIN_a_LB_Y_up), alpha=.2, fill = "blue") + 
  geom_smooth(aes(y=RHIN_a_LB_Y_mean), colour = "darkblue", size =2, se=FALSE) + 
  geom_ribbon(aes(ymin=RHIN_e_LB_Y_lw, ymax=RHIN_e_LB_Y_up), alpha=.2, fill = "red") + 
  geom_smooth(aes(y=RHIN_e_LB_Y_mean), colour = "darkred", size =2, se=FALSE)+ 
#   ylim(0,3)+
  labs(
    x="Year",
    y="Litter Biomass kgC m2",
    title="RHIN"
  )+theme_bw()+ theme(text = element_text(size=30)) + scale_x_continuous(breaks = seq(1997,2009, by=2))


#------------------------------------------------#

DUKE <- as.data.frame(cbind(
  DUKE_e_LB_Y_mean,
  DUKE_a_LB_Y_mean,
  DUKE_e_LB_Y_up,
  DUKE_e_LB_Y_lw,
  DUKE_a_LB_Y_up,
  DUKE_a_LB_Y_lw,
  yrs = unique(year_96_07)
))

h <- ggplot(DUKE, aes(x=yrs))

library(scales)


g3 <- h + geom_ribbon(aes(ymin=DUKE_a_LB_Y_lw, ymax=DUKE_a_LB_Y_up), alpha=.2, fill = "blue") +
  geom_smooth(aes(y=DUKE_a_LB_Y_mean), colour = "darkblue", size =2, se=FALSE) + 
  geom_ribbon(aes(ymin=DUKE_e_LB_Y_lw, ymax=DUKE_e_LB_Y_up), alpha=.2, fill = "red") + 
  geom_smooth(aes(y=DUKE_e_LB_Y_mean), colour = "darkred", size =2, se=FALSE)+ 
#   ylim(0,3)+
  labs(
    x="Year",
    y="Litter Biomass kgC m2",
    title="DUKE"
  ) + theme_bw() + theme(text = element_text(size=30)) + scale_x_continuous(breaks = seq(1997,2009, by=2))

grid.arrange(g1, g2, g3, ncol=3)

####################################################################################################
####################################################################################################
####################################################################################################

#############
## ORNL

a <- which(ORNL_obvs$CO2 == "amb")
e <- which(ORNL_obvs$CO2 == "elev")
sort_yrs_a <- sort(unique(ORNL_obvs$YEAR[a]), index.return=TRUE)
obv_yrs_a <- sort_yrs_a$x
obv_avg_a <- tapply(ORNL_obvs$LITTER.PROD[a], mean, INDEX = ORNL_obvs$YEAR[a])[sort_yrs_a$ix]
sort_yrs_e <- sort(unique(ORNL_obvs$YEAR[e]), index.return=TRUE)
obv_yrs_e <- sort_yrs_e$x
obv_avg_e <- tapply(ORNL_obvs$LITTER.PROD[e], mean, INDEX = ORNL_obvs$YEAR[e])[sort_yrs_e$ix]
obvs <- data.frame(yrs_a = obv_yrs_a, avg_a = as.numeric(obv_avg_a)/1000, yrs_e = obv_yrs_e, avg_e = as.numeric(obv_avg_e)/1000)


gg1 <- ggplot() + 
  geom_smooth(data= ORNL, aes(x=yrs, y=ORNL_a_LB_Y_mean), colour = "darkblue", size =2, se=FALSE) + 
  geom_smooth(data= ORNL, aes(x=yrs, y=ORNL_e_LB_Y_mean), colour = "darkred", size =2, se=FALSE) +
  geom_smooth(data=obvs, aes(x=yrs_a,y=avg_a), colour = "darkblue", size =2, linetype = 5, se=FALSE)+
  geom_smooth(data=obvs, aes(x=yrs_e,y=avg_e), colour = "darkred", size =2,  linetype = 5, se=FALSE)+
  labs(
    x="Year",
    y="Litter Biomass kgC m2",
    title="ORNL"
  )+ theme_bw()+ theme(text = element_text(size=30)) + scale_x_continuous(breaks = seq(1997,2009, by=2))

#############
## RHIN

a <- which(RHIN_obvs$CO2 == "amb")
e <- which(RHIN_obvs$CO2 == "elev")
sort_yrs_a <- sort(unique(RHIN_obvs$YEAR[a]), index.return=TRUE)
obv_yrs_a <- sort_yrs_a$x
obv_avg_a <- tapply(RHIN_obvs$LITTER.PROD[a], mean, INDEX = RHIN_obvs$YEAR[a])[sort_yrs_a$ix]
sort_yrs_e <- sort(unique(RHIN_obvs$YEAR[e]), index.return=TRUE)
obv_yrs_e <- sort_yrs_e$x
obv_avg_e <- tapply(RHIN_obvs$LITTER.PROD[e], mean, INDEX = RHIN_obvs$YEAR[e])[sort_yrs_e$ix]
obvs <- data.frame(yrs_a = obv_yrs_a, avg_a = as.numeric(obv_avg_a)/1000, yrs_e = obv_yrs_e, avg_e = as.numeric(obv_avg_e)/1000)

gg2 <- ggplot() + 
  geom_smooth(data=RHIN, aes(x=yrs, y=RHIN_a_LB_Y_mean), colour = "darkblue", size =2, se=FALSE) + 
  geom_smooth(data=RHIN, aes(x=yrs, y=RHIN_e_LB_Y_mean), colour = "darkred", size =2, se=FALSE) +
  geom_smooth(data=obvs, aes(x=yrs_a,y=avg_a), colour = "darkblue", size =2, linetype = 5, se=FALSE)+
  geom_smooth(data=obvs, aes(x=yrs_e,y=avg_e), colour = "darkred", size =2,  linetype = 5, se=FALSE)+
  labs(
    x="Year",
    y="Litter Biomass kgC m2",
    title="RHIN"
  )+ theme_bw()+ theme(text = element_text(size=30)) + scale_x_continuous(breaks = seq(1997,2009, by=2))

#############
## DUKE

a <- which(DUKE_obvs$CO2 == "amb")
e <- which(DUKE_obvs$CO2 == "elev")
sort_yrs_a <- sort(unique(DUKE_obvs$YEAR[a]), index.return=TRUE)
obv_yrs_a <- sort_yrs_a$x
obv_avg_a <- tapply(DUKE_obvs$LITTER.PROD[a], mean, INDEX = DUKE_obvs$YEAR[a])[sort_yrs_a$ix]
sort_yrs_e <- sort(unique(DUKE_obvs$YEAR[e]), index.return=TRUE)
obv_yrs_e <- sort_yrs_e$x
obv_avg_e <- tapply(DUKE_obvs$LITTER.PROD[e], mean, INDEX = DUKE_obvs$YEAR[e])[sort_yrs_e$ix]
obvs <- data.frame(yrs_a = obv_yrs_a, avg_a = as.numeric(obv_avg_a)/1000, yrs_e = obv_yrs_e, avg_e = as.numeric(obv_avg_e)/1000)

gg3 <-ggplot() + 
  geom_smooth(data=DUKE, aes(x=yrs, y=DUKE_a_LB_Y_mean), colour = "darkblue", size =2, se=FALSE) + 
  geom_smooth(data=DUKE, aes(x=yrs, y=DUKE_e_LB_Y_mean), colour = "darkred", size =2, se=FALSE) +
  geom_smooth(data=obvs, aes(x=yrs_a,y=avg_a), colour = "darkblue", size =2, linetype = 5, se=FALSE)+
  geom_smooth(data=obvs, aes(x=yrs_e,y=avg_e), colour = "darkred", size =2,  linetype = 5, se=FALSE)+
  labs(
    x="Year",
    y="Litter Biomass kgC m2",
    title="DUKE"
  ) + theme_bw()+ theme(text = element_text(size=30)) + scale_x_continuous(breaks = seq(1997,2009, by=2)) +
  + theme(legend.position = c(0.8, 0.2))


grid.arrange(gg1, gg2, gg3, ncol=3)

png(filename = "/home/ecowdery/GitHub_Miscellaneous/FACE/ensem.png", width=1800, height=600)
grid.arrange(g1, g2, g3, ncol=3)
dev.off()

png(filename = "/home/ecowdery/GitHub_Miscellaneous/FACE/bench.png", width=1800, height=600)
grid.arrange(gg1, gg2, gg3, ncol=3)
dev.off()
