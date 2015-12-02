# Insert new pss and css files

# find appropriate input, if not in database, instert new input

siteid <- 853
startdate <- start_date
enddate <- end_date
parent <- ""

n <- 8

<<<<<<< HEAD



formatid <- 10 
#name <- paste0("duke",n,".lat35.5lon-79.5.site")
name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.site"

=======
formatid <- 10 
name <- paste0("duke",n,".lat35.5lon-79.5.site")
>>>>>>> 63bdf98089f2ae522fbd256af8369d8614ae1ec1
cmd10 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")

formatid <- 11
<<<<<<< HEAD
#name <- paste0("duke",n,".lat35.5lon-79.5.css")
name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.css"


=======
name <- paste0("duke",n,".lat35.5lon-79.5.css")
>>>>>>> 63bdf98089f2ae522fbd256af8369d8614ae1ec1
cmd11 <- paste0("INSERT INTO inputs (site_id, format_id, created_at, updated_at, start_date, end_date, name) VALUES (",
                siteid, ", ", formatid, ", NOW(), NOW(), '", startdate, "', '", enddate,"','", name, "')")

formatid <- 15
<<<<<<< HEAD
#name <- paste0("duke",n,".lat35.5lon-79.5.pss")
name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.pss"

=======
name <- paste0("duke",n,".lat35.5lon-79.5.pss")
>>>>>>> 63bdf98089f2ae522fbd256af8369d8614ae1ec1
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
<<<<<<< HEAD
  name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.site"
  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  hostname <- "geo.bu.edu"
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/DUKE", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)
  
  ##################
  #pss
  name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.pss"
  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/DUKE", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)
  
  ##################
  #css
  name <- "/usr2/collab/ecowdery/FACE/RHIN/Rhin.lat45.6lon-89.5.css"
  
  input <- db.query(paste0("SELECT * FROM inputs WHERE name = '", name,"'"), con)
  
  dbfileid <- dbfile.check('Input', input$id, con, hostname)[['id']]
  if(is.null(dbfileid)){
    dbfileid <- dbfile.insert("/home/ecowdery/FACE/DUKE", input$name, 'Input', input$id, con, reuse=TRUE, hostname)
  }
  remove(name,input,dbfileid)

}


# FOR RHIN
  
  ##################
  #site
=======
>>>>>>> 63bdf98089f2ae522fbd256af8369d8614ae1ec1
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
<<<<<<< HEAD
  
=======

>>>>>>> 63bdf98089f2ae522fbd256af8369d8614ae1ec1
}


