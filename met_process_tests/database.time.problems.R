#' Idea for dealing with lots of potentially redundant database file entries 
#' On a daily (?) basis we could run this script, it would check for all current entries in a folder, 
#' find the time overlaps, consolidate them and re-enter them 

require(RPostgreSQL)
require(PEcAn.DB)

dbparms <- list(user="bety", password="bety",host="psql-pecan.bu.edu",dbname="bety",driver="PostgreSQL", write="TRUE")
con      <- db.open(dbparms)

# Example folder to check
machine.id <- 10
input_name <- "Ameriflux_CF_site_0-768"
format.id <- 33
site.id <- 768

# Database query for dbfile entries
check = db.query(
  paste0("SELECT d.container_id, d.id, d.file_path, i.start_date, i.end_date  from dbfiles as d join inputs as i on i.id = d.container_id where i.site_id =",site.id,
         " and d.container_type = 'Input' and i.format_id=",format.id, " and d.machine_id =",machine.id, " and i.name = '", input_name,"'"),con)

colnames(check) <- c("input.id","dbfile.id","file_path","start_date", "end_date")
check[5,] <- check[3,]
check$start_date[5] <- as.POSIXlt("2008/01/01", tz="EST") # for the sake of example I added one that spans multiple years and adds redundancy
check$start_year <- year(check$start_date)
check$end_year <- year(check$end_date)
print(check)


#' So we want to see two intervals returned 
#' (2004-01-01, 2006-12-31) and (2008-01-01, 2010-12-31)
#' I could potentially delete the dbfile entries for the individual years and replace them with the two for the above time frames.
#' Then if later I searched for the time frame 2004-2005, I wouldn't get back a message that my request wasn't in the database 
#' and I'd have to go through the entire download/conversion process and enter a new dbfile for 2004-2005. 

years <- c()
for(i in 1:dim(check)[1]){
  years <- c(years, check$start_year[i]:check$end_year[i])
}
years <- sort(unique(years))

group <- c(0, cumsum(diff(years) != 1)) 
intervals <- tapply(years, group, summary)

ints <- as.data.frame(matrix(NA,length(intervals),2))
colnames(ints) <- c("start","end")

for(i in 1:length(intervals)){
  ints[i,] <- c(intervals[[i]][[1]], intervals[[i]][[6]])
}

print(ints)


################################################################################
# Haven't figured out a good way to do it with time class variables

require(lubridate)

intervals <- list()
for(i in 1:dim(check)[1]){
  x <- new_interval(ymd(check$start_date[i]), ymd(check$end_date[i]),tz = "GMT")
  intervals[[i]] = x
}

Reduce(union, intervals)

