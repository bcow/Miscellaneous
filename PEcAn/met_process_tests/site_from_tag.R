site_from_tag <- function(sitename,tag){
  temp <- regmatches(sitename,gregexpr("(?<=\\().*?(?=\\))", sitename, perl=TRUE))[[1]]
  pref <- paste0(tag,"-")
  site <- unlist(strsplit(temp[grepl(pref,temp)], pref))[2]
  return(site)
}