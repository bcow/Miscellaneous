#!/usr/bin/Rscript
#PEcAn
#data
#xml
#NARR.nc, NARR.zip 

# input files is a xml file specifying what to get
#<input>
#  <type>NARR</type>
#  <start_date>1979-01-01 00:00:00</start_date>
#  <end_date>2013-12-31 23:59:59</end_date>
#</input>

.libPaths("/home/polyglot/R/library")
sink(stdout(),type="message")

# Get command line arguments
#
# The command line arguments should be
# 1. The file name, containing an absolute path, to the input file
# 2. The file name, containing an absolute path, to the output file that will be generated
# 3. The absolute path to a temporary scratch directory that can be used by the script

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 2) {
  myCommand <- substr(commandArgs()[4],10,1000000L)
  print(paste0("Usage:   ", myCommand, " xml_Input_File  NARR-nc_Output_File [tempDirectory]"))
  print(paste0("Example1: ", myCommand, " 1979-2013.xml 1979-2013.NARR-nc [/tmp/watever] "))
  print(paste0("Example2: ", myCommand, " 1979-2013.xml 1979-2013.NARR-nc.zip [/tmp/watever] "))
  q()
} else {
  require(XML)
  require(PEcAn.data.atmosphere)
  require(PEcAn.ED2)
  require(PEcAn.SIPNET)
}

dotPos <- which(strsplit(args[2], "")[[1]]==".")
ext <- substr(args[2],start=dotPos[length(dotPos)], stop=nchar(args[2]))

input <- xmlToList(xmlParse(args[1]))
outputfile <- args[2]
if (length(args) > 2) {
  tempDir <- args[3]
} else {
  tempDir <- "."    
}

# variables definition
start_date <- as.POSIXlt(input$start_date, tz = "GMT")
end_date   <- as.POSIXlt(input$end_date,   tz = "GMT")
overwrite <- TRUE
verbose <- TRUE

# 0 create folders
rawfolder <- file.path(tempDir,input$type, "raw")
dir.create(rawfolder, showWarnings=FALSE, recursive=TRUE)

# 1 download data
download.NARR(rawfolder, start_date=start_date, end_date=end_date, overwrite=overwrite)

filename <- paste0(site,".",substr(start_date,1,4),".nc")
outfile <- file.path(rawfolder, filename)

if (ext == ".zip") {
  rootZip <- paste0(tempDir,"/",input$type,"/",input$site)
  wd <- getwd()
  setwd(paste0(rootZip, "/raw/"))
  system("zip temp.zip ./*")
  #file.rename("temp.zip", paste0(wd,"/", args[2]))   
  file.rename("temp.zip", args[2])   
  setwd(wd)
} else {
  file.rename(outfile,args[2])
}    

if (length(args) > 2) {
  #unlink(args[3], recursive = TRUE) 
} else {
  #unlink(input$type, recursive = TRUE) 
}