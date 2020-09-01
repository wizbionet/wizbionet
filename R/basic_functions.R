#basic functions
#' @import OneR
#' @import utils




#exporting deduplicated gene lists in clipboard####

#' @export
venny.list <- function(x) {
  temp<-x
  temp<-unique(temp)
  temp<-as.character(temp)
  temp <- temp[!is.na(temp)]
  utils::writeClipboard(temp)
  print(paste("items:", length(temp), sep=" "))
}

#' @export
#data.frame column to string####
col_to_string <- function(x) {
  temp<-x
  temp<-unique(temp)
  temp<-as.character(temp)
  temp <- temp[!is.na(temp)]
  summary(temp)
  df<-temp
  return(df)
}

#' @export
#empty to NA####
NoNA.df<- function(x) {
  temp<-x
  temp[temp== ""] <- NA
  temp[temp== "NA"] <- NA
  temp[temp== "NULL"] <- NA
  temp[temp== "-"] <- NA
  temp[temp== "Undetermined"] <- NA
  temp[temp== "NaN"] <- NA
  df<-temp
  return(df)
}



#automatic merging of multiple dataframes and preserving the names###

#' @export
        dataframe.merger<-function(dataframe_list, ID_column){
          #datframe_list==list of dataframes to merge; ID_column=common column used to merge
          for(a in 1:length(dataframe_list))  {
            temp<- dataframe_list[[a]]
            temp<-NoNA.df(temp)
            temp<-unique(temp)
            name1<- names(dataframe_list)[a]
            print(name1)
            temp1<-temp
            if(a==1){
              output<-temp1
              temp1_log<-which( names(output)==ID_column )
              names(output)<-paste(names(output),"_", name1, sep="")
              names(output)[temp1_log]<-ID_column
            } #create output
            output<-output
            if(a!=1){
              names(output)
              names(temp1)
              name1<- names(dataframe_list)[a]
              names(temp1)<-paste(names(temp1),"_", name1, sep="")
              names(temp1)[temp1_log]<-ID_column
              output <- merge(output, temp1, by.x=ID_column, by.y=ID_column, all.x=TRUE, all.y=TRUE, suffixes = c("", ""))
            }


          }

          return(output)

        }



