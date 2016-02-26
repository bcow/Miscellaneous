load("~/GitHub_Miscellaneous/FACE/FACE_CDIAC_obvs.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_summary.Rdata")
load("~/GitHub_Miscellaneous/FACE/FACE_years.Rdata")
#############

require(ggplot2)
require(gridExtra)



ORNL <- as.data.frame(cbind(
  ORNL_e_NPP_Y_mean,
  ORNL_a_NPP_Y_mean,
  ORNL_e_NPP_Y_up,
  ORNL_e_NPP_Y_lw,
  ORNL_a_NPP_Y_up,
  ORNL_a_NPP_Y_lw,
  yrs = unique(year_98_08)
))

h <- ggplot(ORNL, aes(x=yrs))

g1 <- h + geom_ribbon(aes(ymin=ORNL_a_NPP_Y_lw, ymax=ORNL_a_NPP_Y_up), alpha=.2, fill = "blue") + geom_line(aes(y=ORNL_a_NPP_Y_mean), colour = "darkblue", size =2) + 
  geom_ribbon(aes(ymin=ORNL_e_NPP_Y_lw, ymax=ORNL_e_NPP_Y_up), alpha=.2, fill = "red") + geom_line(aes(y=ORNL_e_NPP_Y_mean), colour = "darkred", size =2)+ 
  labs(
    x="Year",
    y="NPP kgC m2 s-1",
    title="ORNL"
  )+ theme_bw()+ theme(text = element_text(size=30))

RHIN <- as.data.frame(cbind(
  RHIN_e_NPP_Y_mean,
  RHIN_a_NPP_Y_mean,
  RHIN_e_NPP_Y_up,
  RHIN_e_NPP_Y_lw,
  RHIN_a_NPP_Y_up,
  RHIN_a_NPP_Y_lw,
  yrs = unique(year_98_08)
))

h <- ggplot(RHIN, aes(x=yrs))

g2 <- h + geom_ribbon(aes(ymin=RHIN_a_NPP_Y_lw, ymax=RHIN_a_NPP_Y_up), alpha=.2, fill = "blue") + geom_line(aes(y=RHIN_a_NPP_Y_mean), colour = "darkblue", size =2) + 
  geom_ribbon(aes(ymin=RHIN_e_NPP_Y_lw, ymax=RHIN_e_NPP_Y_up), alpha=.2, fill = "red") + geom_line(aes(y=RHIN_e_NPP_Y_mean), colour = "darkred", size =2)+ 
  labs(
    x="Year",
    y="NPP kgC m2 s-1",
    title="RHIN"
  )+theme_bw()+ theme(text = element_text(size=30))


#------------------------------------------------#

DUKE <- as.data.frame(cbind(
  DUKE_e_NPP_Y_mean,
  DUKE_a_NPP_Y_mean,
  DUKE_e_NPP_Y_up,
  DUKE_e_NPP_Y_lw,
  DUKE_a_NPP_Y_up,
  DUKE_a_NPP_Y_lw,
  yrs = unique(year_96_07)
  ))

h <- ggplot(DUKE, aes(x=yrs))

g3 <- h + geom_ribbon(aes(ymin=DUKE_a_NPP_Y_lw, ymax=DUKE_a_NPP_Y_up), alpha=.2, fill = "blue") + geom_line(aes(y=DUKE_a_NPP_Y_mean), colour = "darkblue", size =2) + 
  geom_ribbon(aes(ymin=DUKE_e_NPP_Y_lw, ymax=DUKE_e_NPP_Y_up), alpha=.2, fill = "red") + geom_line(aes(y=DUKE_e_NPP_Y_mean), colour = "darkred", size =2)+ 
  labs(
    x="Year",
    y="NPP kgC m2 s-1",
    title="DUKE"
  ) + theme_bw() + theme(text = element_text(size=30))


grid.arrange(g1, g2, g3, ncol=3)

h <- ggplot(ORNL, aes(x=yrs))

gg1 <- h + geom_line(aes(y=ORNL_a_NPP_Y_mean), colour = "darkblue", size =2) + geom_line(aes(y=ORNL_e_NPP_Y_mean), colour = "darkred", size =2)+ 
  labs(
    x="Year",
    y="NPP kgC m2 s-1",
    title="ORNL"
  )+ theme_bw()+ theme(text = element_text(size=30))

h <- ggplot(RHIN, aes(x=yrs))

gg2 <- h + geom_line(aes(y=RHIN_a_NPP_Y_mean), colour = "darkblue", size =2) + geom_line(aes(y=RHIN_e_NPP_Y_mean), colour = "darkred", size =2)+ 
  labs(
    x="Year",
    y="NPP kgC m2 s-1",
    title="RHIN"
  )+ theme_bw()+ theme(text = element_text(size=30))

h <- ggplot(DUKE, aes(x=yrs))

gg3 <- h + geom_line(aes(y=DUKE_a_NPP_Y_mean), colour = "darkblue", size =2) + geom_line(aes(y=DUKE_e_NPP_Y_mean), colour = "darkred", size =2)+ 
  labs(
    x="Year",
    y="NPP kgC m2 s-1",
    title="DUKE"
  )+ theme_bw()+ theme(text = element_text(size=30))

grid.arrange(gg1, gg2, gg3, ncol=3)


