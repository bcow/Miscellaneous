
require(RCurl)
require(httr)
require(XML)
require(ncdf4)


###################################################################################################
# Download Ameriflux data using online xml file
###################################################################################################

base = "http://dap.ncsa.illinois.edu:8184/convert/pecan.zip/"
xml.file = "http%3A%2F%2Fbrowndog.ncsa.illinois.edu%2Fexamples%2FUS-Dk3-2001-2003.xml"
url = paste0(base,xml.file)
html <- getURL(url)
html_parsed <- htmlParse(html, isHTML = TRUE)
link <- getHTMLLinks(html)

# td <- tempdir() 
# tf <- tempfile(tmpdir=td, fileext=".zip") 

td <- "/Users/elizabethcowdery/R Projects/GitHub_Miscellaneous/BrownDog/test"
tf <- file.path(td,"test.zip")

download.file(link, tf) 
fname <- unzip(tf, list=TRUE)$Name
unzip(tf, files=fname, exdir=td, overwrite=TRUE) 
fpath <- file.path(td, fname)

for(i in 1:length(fpath)){
  nc_name <- basename(fpath[i])
  assign(nc_name, nc_open(fpath[i]))
}


###################################################################################################
# Download Ameriflux data using localhost xml file
###################################################################################################

host <- "http://dap.ncsa.illinois.edu:8184/convert"
output.format <- "pecan.zip"
url <- file.path(host,output.format) 


html <- POST(url, body = list("pecan.xml" = upload_file("BrownDog/Ameriflux.xml"),verbose()))
html_parsed <- content(html)
link <- getHTMLLinks(html_parsed)

td <- "/Users/elizabethcowdery/R Projects/GitHub_Miscellaneous/BrownDog/test"
tf <- file.path(td,"test.zip")

download.file(link, tf) 
fname <- unzip(tf, list=TRUE)$Name
unzip(tf, files=fname, exdir=td, overwrite=TRUE) 
fpath <- file.path(td, fname)

for(i in 1:length(fpath)){
  nc_name <- basename(fpath[i])
  assign(nc_name, nc_open(fpath[i]))
}

###################################################################################################
# Download Ameriflux data using xml file
###################################################################################################

host <- "http://dap.ncsa.illinois.edu:8184/convert"
output.format <- "pecan.zip"
url <- file.path(host,output.format) 

met <- "ameriflux"
site <- "US-Dk3"
start_date <- "2003-01-01 00:00:00"
end_date <- "2004-12-31 23:59:59"


xml_text = newXMLNode("input")
newXMLNode("type", met, parent = xml_text)
newXMLNode("site", site, parent = xml_text)
newXMLNode("start_date", start_date, parent = xml_text)
newXMLNode("end_date", end_date, parent = xml_text)
xml_text <- saveXML(xml_text)

# xml_text2 = 
#   "<input>
#   <type>ameriflux</type>
#   <site>US-Dk3</site>
#   <start_date>2003-01-01 00:00:00</start_date>
#   <end_date>2004-12-31 23:59:59</end_date>
# </input>"

html <- postForm(uri = url, "pecan.xml" = fileUpload(filename = "pecan.xml", contents = xml_text))
link <- getHTMLLinks(html)

td <- "/Users/elizabethcowdery/R Projects/GitHub_Miscellaneous/BrownDog/test"
tf <- file.path(td,"test.zip")

cat("Attempting download from ", link,"\n")

dl_file <- function(link, tf, i){
  r <- try(download.file(link, tf, quiet = TRUE), silent = TRUE)
  if(inherits(r, 'try-error') & i <= 1000){
    cat("*")
    dl_file(link, tf, i)
  }
  if(inherits(r, 'try-error') & i > 1000){
    print("Download Failed")
  }
  if(inherits(r, 'integer')){
    cat("\nDownload Succeeded")
  }
}

i = 1
dl_file(link, tf, i)

fname <- unzip(tf, list=TRUE)$Name
unzip(tf, files=fname, exdir=td, overwrite=TRUE) 

###################################################################################################
# Testing new function
###################################################################################################

source('~/R Projects/GitHub_Miscellaneous/BrownDog/download.BrownDog.Ameriflux.R')

browndog <- list(host = "http://dap.ncsa.illinois.edu:8184/convert")
site <- "US-Dk3"
start_date <- "2003-01-01 00:00:00"
end_date <- "2004-12-31 23:59:59"
outfolder  <- "/Users/elizabethcowdery/R Projects/GitHub_Miscellaneous/BrownDog/test"

download.BrownDog.Ameriflux(browndog, site, start_date, end_date, outfolder)


