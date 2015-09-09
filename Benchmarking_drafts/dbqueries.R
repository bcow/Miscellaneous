#' PSQL commands that may become their own function:
#' 
#' Given input ID
#' Query  input id and machine id -> path
#' Query formats
#' Query site

require(PEcAn.all)
require(RPostgreSQL)
require(XML)
require(data.table)

for (i in dbListConnections(PostgreSQL())) db.close(i) #close any stray database connections
options(digits=10)

xml_file <- "/home/ecowdery/GitHub_Miscellaneous/FACE/FACE.pecan2_pecan.xml"
settings <- read.settings(xml_file)
# settings <- xmlToList(xmlParse(xml_file))

site       = settings$run$site 
input_met  = settings$run$inputs$met
start_date = settings$run$start.date 
end_date   = settings$run$end.date
model      = settings$model$type
host       = settings$run$host
dbparms    = settings$database$bety 
dir        = settings$run$dbfiles
browndog   = settings$browndog

con      <- db.open(dbparms)
username <- ""  


input.id <- 1000000519
site.id <- site$id
host_name <- "localhost"
  
#######

db.query.file.path <- function(input.id, host_name){
  machine.host <- ifelse(host$name == "localhost",fqdn(),host_name)
  machine = db.query(paste0("SELECT * from machines where hostname = '",machine.host,"'"),con)
  dbfile = db.query(paste("SELECT file_name,file_path from dbfiles where container_id =",input.id," and container_type = 'Input' and machine_id =",machine$id),con)
  path <- file.path(dbfile$file_path,dbfile$file_name)
  if(file.exists(path)){
    return(path)
  }else{
    logger.error("Invalid file path")
  }
}

file.path <- db.query.file.path(input.id,host_name)

"SELECT * from formats as f join formats_variables as fv on f.id = fv.format_id join variables as v on fv.variable_id = v.id where f.id =  #;"

db.query.format.vars <- function(input.id){
  
  f <- db.query(paste("SELECT * from formats as f join inputs as i on f.id = i.format_id where i.id = ", input.id),con)
  
  fv <- db.query(paste("SELECT variable_id,name,unit from formats_variables where format_id = ", f$id),con)
  colnames(fv) <- c("variable_id", "name", "units")
  
  n <- dim(fv)[1]
  vars <- lapply(1:n, function(i) db.query(paste("SELECT id,units,name,standard_name,standard_units from variables where id = ", fv$variable_id[i]),con))
  vars <- do.call(rbind, vars)
  colnames(vars) <- c("variable_id", "bety_units", "bety_name", "CF_name", "CF_units")
  
  vars_names_units <- merge(form_var, vars, by="variable_id")
  vars_names_units <- var_names_units[c("variable_id", "name", "bety_name", "CF_name", "units", "bety_units", "CF_units")]
  
  return(list(f, vars_names_units))
}

f_v <- db.query.format.vars(input.id)

formats <- f_v[[1]]
vars_names_units <- f_v[[2]]

test_vecs <- function(x = "x = c(1,2)"){  
  if(x == "x = c()"){
    x = "x = c(1,2,3,4)"
  }
  x = eval(parse(text = x))
  print(x)
}

remove(x)
x = "x = c(1,2,3)"
test_vecs()
test_vecs(x)
test_vecs(x = "x = c()")


db.query.site <- function(site.id,con){
  site <- db.query(paste("SELECT *, ST_X(ST_CENTROID(geometry)) AS lon, ST_Y(ST_CENTROID(geometry)) AS lat FROM sites WHERE id =",site.id),con)
  if(nrow(site)==0){logger.error("Site not found"); return(NULL)}
  if(!(is.na(site$lat)) && !(is.na(site$lat))){
    return(site)
  }
}
  