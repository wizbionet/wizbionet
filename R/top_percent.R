

#' @export
top_percent<-function(inputDF, landmark_col, cols_to_cluster, cutoff){

  if(missing(cutoff)){
    cutoff=25
  }



  inputDF<-as.data.frame(inputDF)
  inputDF<-NoNA.df(inputDF)

  invisible(utils::capture.output(inputDF[,landmark_col]<-as.character(inputDF[,landmark_col])))
  a=1
  b=1


  output<-inputDF
  output$rows<-paste('r',1:nrow(inputDF))
  rm(temp,temp1,temp2)
  names(output)
  for (a in 1:length(cols_to_cluster)) {
    input<-output[,c(landmark_col, cols_to_cluster[a], "rows")]
    invisible(utils::capture.output(input[,cols_to_cluster[a]][is.na(input[,cols_to_cluster[a]])] <- 0))
    invisible(utils::capture.output(inputDF[,cols_to_cluster[a]]<-as.numeric(paste(inputDF[,cols_to_cluster[a]]))))

    input <- input[order(input[,cols_to_cluster[a]], decreasing = TRUE),]
    #calculate cutoff
    temp<- input
    names(temp)
    temp<-cutoff*nrow(temp)/100
    x<- round(temp)

    temp1<- input[1:x,]
    names(temp1)
    y<-temp1[nrow(temp1),2]

    #subset all values close to cutoff
    temp2<-subset(input, input[,2]>=y)

    name1<-paste("clus",cutoff,"p_" ,cols_to_cluster[a],sep="")
    temp_log<-output[,"rows"] %in% temp2[,"rows"]

    output[,name1]<-temp_log
    x<-subset(output, output[,name1]==TRUE)
    z<- (nrow(x)*100/nrow(output))



    print(paste(cols_to_cluster[a], " top", cutoff, "% of values: selected " ,round(z), "% of rows (" ,nrow(x),
                " rows) for nr higher than ", round(y, digits=2), sep=''))

  }
  output$rows<-NULL
  return(output)
}
