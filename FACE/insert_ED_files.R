# Insert new pss and css files

# find appropriate input, if not in database, instert new input

siteid <- 853
startdate <- start_date
enddate <- end_date
parent <- ""

n <- 8

formatid <- 10 
name <- paste0("duke",n,".lat35.5lon-79.5.site")
cmd10 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")

formatid <- 11
name <- paste0("duke",n,".lat35.5lon-79.5.css")
cmd11 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")

formatid <- 15
name <- paste0("duke",n,".lat35.5lon-79.5.pss")
cmd15 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")


db.query(cmd10, con)
db.query(cmd11, con)
db.query(cmd15, con)



inp <- db.query(paste0("SELECT * FROM inputs WHERE site_id=", siteid, " AND format_id=", formatid, " AND start_date='", startdate, "' AND end_date='", enddate, "'" , parent, ";"), con)


# return input id




# find appropriate dbfile, if not in database, insert new dbfile
hostname <- "pecan2.bu.edu"

for(n in 1:8){
  
  ##################
  #site
  name <- paste0("duke",n,".lat35.5lon-79.5.site")
  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/DUKE", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)
  
  ##################
  #pss
  name <- paste0("duke",n,".lat35.5lon-79.5.pss")
  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/DUKE", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)
  
  ##################
  #css
  name <- paste0("duke",n,".lat35.5lon-79.5.css")
  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/DUKE", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)

}


