download.BrownDog.Ameriflux <- function(browndog, site, start_date, end_date, outfolder){
  
  host <- browndog$host 
  # host <- "http://dap.ncsa.illinois.edu:8184/convert"
  output.format <- "pecan.zip"
  url <- file.path(host,output.format) 
  
  xml_text = newXMLNode("input")
  newXMLNode("type", "ameriflux", parent = xml_text)
  newXMLNode("site", site, parent = xml_text)
  newXMLNode("start_date", start_date, parent = xml_text)
  newXMLNode("end_date", end_date, parent = xml_text)
  xml_text <- saveXML(xml_text)
  
  html <- postForm(uri = url, "pecan.xml" = fileUpload(filename = "pecan.xml", contents = xml_text))
  link <- getHTMLLinks(html)
  
  tf <- file.path(outfolder, paste("Ameriflux.zip"))
  
  paste("Attempting download from ", link)
  
  dl_file <- function(link, tf, i){
    r <- try(download.file(link, tf, quiet = TRUE), silent = TRUE)
    if(inherits(r, 'try-error') & i <= 1000){
      cat("*")
      dl_file(link, tf, i)
    }
    if(inherits(r, 'try-error') & i > 1000){
      print("Download failed after 1000 attempts")
      return()
    }
    if(inherits(r, 'integer')){
      cat("\nDownload succeeded!")
    }
  }
  
  i = 1
  dl_file(link, tf, i)
  
  fname <- unzip(tf, list=TRUE)$Name
  unzip(tf, files=fname, exdir=outfolder, overwrite=TRUE) 
  file.remove(tf)
  
}

