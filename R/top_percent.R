

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
  top_rec<-vector()
  a=1
  for (a in 1:length(cols_to_cluster)){
    invisible(utils::capture.output(inputDF[,cols_to_cluster[a]]<-as.numeric(paste(inputDF[,cols_to_cluster[a]]))))
    input<-inputDF[,c(landmark_col ,cols_to_cluster[a])]
    input <- input[order(input[,cols_to_cluster[a]], decreasing = TRUE),]
    invisible(utils::capture.output(input[,2]<-as.numeric(paste(input[,2]))))
    invisible(utils::capture.output(input[,2][is.na(input[,2])] <- 0))
    invisible(utils::capture.output(input[,1]<-as.character(paste(input[,1]))))
    #calculate cutoff
    temp<- unique(dplyr::select(input, 2))
    temp<-cutoff*nrow(temp)/100
    x<- round(temp)

    temp1<- input[1:x,]
    y<-temp1[nrow(temp1),2]

    #subset all values close to cutoff
    temp2<-subset(input, input[,2]>=y)

    name1<-paste("clus",cutoff,"p_" ,cols_to_cluster[a],sep="")
    temp_log<-input[,2] %in% temp2[,2]

    output[,name1]<-temp_log
    x<-subset(output, output[,name1]==TRUE)
    z<- (nrow(x)*100/nrow(output))



    print(paste(cols_to_cluster[a], " top", cutoff, "% of values: selected " ,round(z), "% of rows (" ,nrow(x),
                " rows) for nr higher than ", round(y, digits=2), sep=''))

  }

  return(output)
}
