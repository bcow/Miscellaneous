path <- "/Users/elizabethcowdery/R Projects/GE656_TerrEcosystems/Final_Project_FACE/npp-cdiac.csv"

dat <- read.csv(path,header = T)
dat.split <- split(dat, dat$SITE)

lapply(names(dat.split), function(name) write.csv(dat.split[[name]], file = paste0("FACE/npp-cdiac.",name,".csv"), row.names = F))