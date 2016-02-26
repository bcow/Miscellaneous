# Insert new pss and css files

# find appropriate input, if not in database, instert new input

siteid <- 853
startdate <- start_date
enddate <- end_date
parent <- ""


####################################
## Insert inputs

n_ornl <- 5
n_duke <- 8

for(n in 1:n_ornl){
  # ---- SITE ---- #
  formatid <- 10 
  
  name <- paste0("ORNL",n,".lat35.5lon-84.5.site")
  #name <- paste0("duke",n,".lat35.5lon-79.5.site")
  #name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.site"
  
  cmd10 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                  siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")
  
  
  # ---- CSS ---- #
  formatid <- 11
  
  name <- paste0("ORNL",n,".lat35.5lon-84.5.css")
  #name <- paste0("duke",n,".lat35.5lon-79.5.css")
  #name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.css"
  
  cmd11 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                  siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")
  
  # ---- PSS ---- #
  formatid <- 15
  
  name <- paste0("ORNL",n,".lat35.5lon-84.5.pss")
  #name <- paste0("duke",n,".lat35.5lon-79.5.pss")
  #name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.pss"
  
  cmd15 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                  siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")
  
  db.query(cmd10, con)
  db.query(cmd11, con)
  db.query(cmd15, con)
  
}

.lat35.5lon-84.5.site

oops <- "DELETE FROM inputs WHERE name = 'ORNL8.lat35.5lon-84.5.pss'"

oops <- "DELETE FROM dbfiles WHERE file_name = 'ORNL1.lat35.5lon-84.5'"
db.query(oops, con)

####################################
## find appropriate dbfile, if not in database, insert new dbfile

hostname <- "pecan2.bu.edu"

hostname <- "geo.bu.edu"

for(n in 1:5){
  
  ##################
  #site

  # name <- paste0("duke",n,".lat35.5lon-79.5.site")
  # name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.site"
  name <- paste0("ORNL",n,".lat35.5lon-84.5.site")

  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/ORNL", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)
  
  ##################
  #pss
  
  # name <- paste0("duke",n,".lat35.5lon-79.5.pss")
  name <- paste0("ORNL",n,".lat35.5lon-84.5.pss")

  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/ORNL", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)
  
  ##################
  #css

  # name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.css"
  # name <- paste0("duke",n,".lat35.5lon-79.5.css")
  name <- paste0("ORNL",n,".lat35.5lon-84.5.css")
  
  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/ORNL", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)

}


