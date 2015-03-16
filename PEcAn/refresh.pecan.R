refresh.pecan <- function(){
  
  detach("package:PEcAn.all", unload=TRUE)
  detach("package:PEcAn.uncertainty", unload=TRUE)
  detach("package:PEcAn.settings", unload=TRUE)
  detach("package:PEcAn.MA", unload=TRUE)
  detach("package:PEcAn.data.land", unload=TRUE)
  detach("package:PEcAn.data.remote", unload=TRUE)
  detach("package:PEcAn.data.atmosphere", unload=TRUE)
  detach("package:PEcAn.assim.batch", unload=TRUE)
  detach("package:PEcAn.DB", unload=TRUE)
  detach("package:PEcAn.priors", unload=TRUE)
  detach("package:PEcAn.utils", unload=TRUE)
  
  system(paste("./scripts/build.sh"))
  
  system("R --save")
  
  print("command-shift-0 ")
}