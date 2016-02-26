rm(list = setdiff(ls(), lsf.str()))  # clear variables but not sourced functions
for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections
source('~/pecan/db/R/query.file.path.R')
source('~/pecan/db/R/query.format.vars.R')
source('~/pecan/modules/benchmark/R/load.data.R')


require(PEcAn.all)
require(PEcAn.benchmark)
require(RPostgreSQL)
require(XML)

#setup connection and host information

dbparms <- list(
  user = "bety",
  password = "bety",
  host = "psql-pecan.bu.edu",
  write = TRUE,
  driver = "PostgreSQL"
)
con      <- db.open(dbparms)

# "/home/ecowdery/GitHub_Miscellaneous/FACE/npp-cdiac.Rhinelander.csv"


input.id <- 1000000519 # RHIN
input.id <- 1000000542 # DUKE
input.id <- 1000000651 # ORNL

inputids <- c(1000000519,1000000542,1000000651)

host_name <- "localhost"
metrics <- "test"

## Calc benchmark

for(input.id in inputids){
  data.path <- query.file.path(input.id,host_name,con)
  format <- query.format.vars(input.id,con)
  obvs <- load.data(data.path, format, start_year = NA, end_year=NA, site=NA)
  assign(paste0(obvs$SITE[[1]],"_obvs"),obvs)
}

RHIN_obvs <- Rhinelander_obvs

save(ORNL_obvs,RHIN_obvs,DUKE_obvs, file = "~/GitHub_Miscellaneous/FACE/FACE_CDIAC_obvs.Rdata")


data.path <- query.file.path(input.id,host_name,con)
format <- query.format.vars(input.id,con)

## Calc metrics

obvs <- load.data(data.path, format, start_year = NA, end_year=NA, site=NA)

ORNL_obvs <- obvs
RHIN_obvs <- obvs
DUKE_obvs <- obvs

save(ORNL_obvs, RHIN_ob)

runid <- 1000328828
outdir <- "/fs/data2/output/PEcAn_1000000901/out/1000328828"
start_year= 2000
end_year= 2001
var=c("NPP")

model <- read.output(runid, outdir, start_year, end_year, var=var)

nc <- nc_open("/fs/data2/output/PEcAn_1000000901/out/1000328828//analysis-T-2000-00-00-000000-g01.h5")
nc2 <- nc_open("/fs/data2/output/PEcAn_1000000901/out/1000328828//2000.nc")
nc3 <- nc_open("")

nc.get.variable.list(nc2)

format <- query.format.vars(input.id,con)