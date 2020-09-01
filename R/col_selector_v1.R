
#function for selecting/ reordering columns with similar names within a dataframe
# use special characters to extract key_words: *=any character; ^=block beginning of the string , $=block end of the string

#example###
      # inputDF<-iris
      # key_words<-c("Species", "*Width", "*Length")
      # temp<-col_selector(inputDF,key_words)

#' @export

col_selector<-function(inputDF, key_words){
  temp<-names(inputDF)

  for(a in 1:length(key_words)){
  temp_log<-grepl(key_words[a], temp)
  summary(temp_log)
  temp1<-subset(temp, temp_log==TRUE)
  temp2= dplyr::select ( inputDF,temp1)

  if(a==1){
  result=temp2    }

  if(a>1){
    result=cbind(result, temp2)

  }


  }
  #result=unique(result)
  names(result)

  return(result)

}
