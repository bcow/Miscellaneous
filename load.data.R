##' Generic function to convert input files containing observational data to 
##' a common PEcAn format. 
##' 
##' This should be the same as the read.output function:
##' This function uses MsTMIP variables except that units of (kg m-2 d-1)  
##' are converted to kg ha-1 y-1. 
##' 
##' Currently this function converts
##' 
##' Carbon fluxes: GPP, NPP, NEE, TotalResp, AutoResp, HeteroResp,
##' DOC_flux, Fire_flux, and Stem (Stem is specific to the BioCro model)
##' 
##' Water fluxes: Evaporation (Evap), Transpiration(TVeg),
##' surface runoff (Qs), subsurface runoff (Qsb), and rainfall (Rainf).


load.data <- function(start_date, end_date, files, v = "vars = c()", u = "units = c()", nu = "newunits = c()", ){
  
  require(lubridate)
  
  if(v == "vars = c()"){
    v = 'vars = c("GPP", "NPP", "NEE", "TotalResp", "AutoResp", "HeteroResp",
             "DOC_flux", "Fire_flux", "Evap", "TVeg", "Qs", "Qsb", "Rainf")'
  }
  vars = eval(parse(text = v))
  print(vars)
  
  
  if(u == "units = c()"){
    u = 'units = rep("kg m-2 s-1", length(vars))'
  }
  units = eval(parse(text = u))
  print(units)
  
  if(nu == "newunits = c()"){
    nu = 'newunits = rep("kg ha-1 yr-1", length(vars))'
  }
  newunits = eval(parse(text = nu))
  print(newunits)
  
  test <- function(vars, units){
    print(vars)
    print(units)
  }
  
  start.year <- year(start_date)
  end.year <- year(end_date)
  
  fcn1 <- paste0("load.",input$format$name)
  fcn2 <- paste0("load.",input$format$mimetype)
  if(exists(fcn1)){
    fcn <- fcn1
  }else if(exists(fcn2)){
    fcn <- fcn2
  }else{
    logger.warn("no load data for current mimetype - converting using browndog")
    # Browndog
    # convert the observations to a mime pecan can use
    # ex: exel -> csv
  }
  
  dat <- apply(fcn,observation)
  

  return(result) 
}

#   #  loop over inputs (ie figuring out what we’re dealing with):
#   #     (Future design: Use PEcAn API to get file from remote, not local)
#   
#   for(i in 1:length(settings$run$inputs)) {
#     input <- settings$run$inputs[[i]]
#     if (is.null(input)) next
#     
#     input.tag <- names(settings$run$input)[i]
#     
#     if(input.tag == 'observation') {
#      
#       host       = settings$run$host
#       ifelse(host$name == "localhost", machine.host <- fqdn(), machine.host <- host$name)
#       machine = db.query(paste0("SELECT * from machines where hostname = '",machine.host,"'"),con)
#       
#       input.id   <- settings$run$inputs[[i]][['id']]
#       path <- settings$run$inputs[[i]][['path']]
#       
#       
#       if (!is.null(path)){
#         dbfile.id = db.query(paste0("SELECT id from dbfiles where file_name = '", basename(path) ,"' AND file_path = '", dirname(path) ,"'"),con)[[1]]
#       }else{
#         dbfile.id = db.query(paste0("SELECT id from dbfiles where container_id = '", input.id ,"' AND machine_id = '", machine$id ,"'"),con)[[1]]
#       }
#       
#       input <- db.query(paste("SELECT * inputs WHERE id = ", input.id))
#       fcn1 <- paste0("load.",input$format$name)
#       fcn2 <- paste0("load.",input$format$mimetype)
#       if(exists(fcn1)){
#         fcn <- fcn1
#       }else if(exists(fcn2)){
#         fcn <- fcn2
#       }else{
#         logger.warn("no load data for current mimetype - converting using browndog")
#         # Browndog
#         # convert the observations to a mime pecan can use
#         # ex: exel -> csv
#         }
#       
#       dat <- apply(fcn,observation) # excpt this needs to remote etc ... 
#       
# 



#   

#   load.data.core(long list of arguments) OR add a db query API option?
#   look up arguments in dB
#   
#   

load.[format](inputs) —> outputs - should be Bety var names, units
#   what is the formats record
#   what is the table that combines the info from the formats variables record and the entry in  variables
#   
#   
load.[mimetype](inputs) —> outputs - should be Bety var names, units
#   inputs
#   file, url <— anything that can be read from the read.*() function
#   formats record - needs to be queried from the database, stored as a list
#   variables = NULL[all]


#   steps
#     look for format loader
#     look for mime loader
#     ask BrownDog to convert current mime to known mime
#     for example, an excel file —> ask Brown Dog to give it back to us as a CSV
#     DAP —> convert
#     have a list of preferred types like: 1) ncdf 2) CSV
#     DTS —> format record
# 
# Input ID -> format ID -> select * form formats to variables join on variable id where format id = x
# 
# generic conversion function that reads in current units, and the bety units, udunits conversion 
# 
# 
# * all database taken care of 

