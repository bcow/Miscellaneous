library(PEcAn.all)
library(RPostgreSQL)

dbparms <- list(driver="PostgreSQL" , user = "bety", dbname = "bety", password = "bety", host = "psql-pecan.bu.edu")
con     <- db.open(dbparms)

#######################################################
# Full version by Mike

InsertString = paste0("INSERT INTO sites(sitename,country,mat,map,notes,geometry,user_id,created_at,updated_at) VALUES(",
                      "'",sitename,"', ",
                      "'",country,"', ",
                      mat,", ",
                      map,", ",
                      "'",notes,"', ",
                      "ST_GeomFromText('POINT(",lon," ",lat," ",elev,")', 4326), ",
                      user.id,
                      ", NOW(), NOW() );")
db.query(InsertString,con)        

#######################################################
# My simplified example

sitename <- "Cornell Plantations"
lat <- 42.452781
lon <- -76.463965
elev <- 0
country <- "United States"
notes <- "lololololol"

InsertString = paste0("INSERT INTO sites(sitename,country,notes,geometry,created_at,updated_at) VALUES(",
                      "'",sitename,"', ",
                      "'",country,"', ",
                      "'",notes,"', ",
                      "ST_GeomFromText('POINT(",lon," ",lat," ",elev,")', 4326) ",
                      ", NOW(), NOW() );")
db.query(InsertString,con) 

