find.prefix <- function(files){
files.split <- (strsplit(files, "[.]"))
files.split <- lapply(files.split, `length<-`,max(unlist(lapply(files.split, length))))
files.df <- as.data.frame(do.call(rbind, files.split))
files.uniq <- sapply(files.df, function(x)length(unique(x)))

prefix <- ""
ifelse(files.uniq[1] == 1,prefix <- as.character(files.df[1,1]),return(prefix))

  for(i in 2:length(files.uniq)){
    if(files.uniq[i]==1){
      prefix <- paste(prefix,as.character(files.df[1,i]),sep = ".")
    }else{
      return(prefix)
    }
  }
return(prefix)
}