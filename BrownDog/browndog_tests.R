
require(RCurl)
require(XML)
require(ncdf4)


###################################################################################################
# Download Ameriflux data using online xml file

url = "http://dap.ncsa.illinois.edu:8184/convert/pecan.zip/http%3A%2F%2Fbrowndog.ncsa.illinois.edu%2Fexamples%2FUS-Dk3-2001-2003.xml"
html <- getURL(url)
html_parsed <- htmlParse(html, isHTML = TRUE)
link <- getHTMLLinks(html)

# td <- tempdir() 
# tf <- tempfile(tmpdir=td, fileext=".zip") 

td <- "/Users/elizabethcowdery/R Projects/GitHub_Miscellaneous/BrownDog/test"
tf <- file(td,"test.zip")

download.file(link, tf) 
fname <- unzip(tf, list=TRUE)$Name
unzip(tf, files=fname, exdir=td, overwrite=TRUE) 
fpath <- file.path(td, fname)

for(i in 1:length(fpath)){
  nc_name <- basename(fpath[i])
  assign(nc_name, nc_open(fpath[i]))
}

###################################################################################################
# Download Ameriflux data using local xml file


fileUpload(filename = character(), contents = character(), contentType = character())

postForm(uri,
         fileOid = "1234",
         analyticalGroup = "bob",
         theFile = fileUpload(filename = "~/temp/thedata.txt",contentType = "text/amazing"),
          .encoding="uft-8")




url = "http://dap.ncsa.illinois.edu:8184/convert/pecan.zip/http%3A%2F%2Fbrowndog.ncsa.illinois.edu%2Fexamples%2FUS-Dk3-2001-2003.xml"
html <- getURL(url)


html_parsed <- htmlParse(html, isHTML = TRUE)
link <- getHTMLLinks(html)

# td <- tempdir() 
# tf <- tempfile(tmpdir=td, fileext=".zip") 

td <- "/Users/elizabethcowdery/R Projects/GitHub_Miscellaneous/BrownDog/test"
tf <- file(td,"test.zip")

download.file(link, tf) 
fname <- unzip(tf, list=TRUE)$Name
unzip(tf, files=fname, exdir=td, overwrite=TRUE) 
fpath <- file.path(td, fname)

for(i in 1:length(fpath)){
  nc_name <- basename(fpath[i])
  assign(nc_name, nc_open(fpath[i]))
}



