
##' @name find.prefix
##' @title find.prefix
##' @export
##' @param files
##' @author Betsy Cowdery
find.prefix <- function(files){
  
  if(length(files)==1){
    tail <- tail(unlist(strsplit(files, "/")),1)
    prefix <- head(unlist(strsplit(tail, "[.]")),1)
    return(prefix)
  }
  
  files.split <- try(strsplit(unlist(files), "[.]"), silent = TRUE)
  
  if(!inherits(files.split, 'try-error')){
    
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
  }else{   
    bases <- lapply(as.character(files),basename)
    if(length(unique(bases))==1){
      prefix <- bases[1]
    }else{
      prefix <- ""
    }
  }
  return(prefix)
}
