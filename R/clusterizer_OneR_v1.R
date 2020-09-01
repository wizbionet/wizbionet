#' @importFrom OneR bin

#' @export



clusterizer_oneR<-function(inputDF, landmark_col, cols_to_cluster){

  inputDF<-as.data.frame(inputDF)
  inputDF<-NoNA.df(inputDF)
  invisible(utils::capture.output(inputDF[,landmark_col]<-as.character(inputDF[,landmark_col])))
  a=1
  b=1

  output<-inputDF
  top_rec<-vector()
  a=1
  for (a in 1:length(cols_to_cluster)){
    suppressWarnings(inputDF[,cols_to_cluster[a]]<-suppressWarnings(as.numeric(paste(inputDF[,cols_to_cluster[a]]))))

    input<-inputDF[,c(landmark_col ,cols_to_cluster[a])]
    invisible(utils::capture.output(input[,2]<-suppressWarnings(as.numeric(paste(input[,2])))))
    invisible(utils::capture.output(input[,2][is.na(input[,2])] <- 0))
    invisible(utils::capture.output(input[,1]<-as.character(paste(input[,1]))))
    #clusterin


    t <- try(OneR::bin(input[,2], nbins = 4, method = "clusters", na.omit = TRUE),silent = TRUE)

    #kmeans if error
    if(t[1]=="Error : empty cluster: try a better set of initial centers\n")  {
      clusters<-stats::kmeans(input[,2],4, iter.max = 30, algo="Lloyd")
      input$clusters<- clusters$cluster
      print(paste('uses Kmeans instead of OneR for column', cols_to_cluster[a] ))
    }

    if(t[1]!="Error : empty cluster: try a better set of initial centers\n")  {
      #print(paste('uses OneR'))
      input$clusters <-OneR::bin(input[,2], nbins = 4, method = "clusters", na.omit = TRUE) #code for OneR
      #clusters<-kmeans(input[,2],4, iter.max = 30, algo="Lloyd")
      #input$clusters<- clusters$cluster



    }


    input$rows<-c(1:nrow(input))
    temp2<- input[order(input[,2], decreasing = TRUE),]
    temp2<-as.character(unique(temp2$cluster))
    #name clusters

    input<-as.data.frame(input)
    input[,3]<-as.character(paste(input[,3]))
    input[,3][input[,3]==temp2[1]] <- 'cl1' #highest
    input[,3][input[,3]==temp2[2]] <- 'cl2'
    input[,3][input[,3]==temp2[3]] <- 'cl3'
    input[,3][input[,3]==temp2[4]] <- 'cl4' #lowest
    A<-subset(input, input$cluster=="cl1")
    B<-subset(input, input$cluster=="cl2")

    temp<-rbind(A,B)
    #names
    name1<-paste("top_rec", cols_to_cluster[a],sep="_")
    name2<-paste("clus", cols_to_cluster[a],sep="_")
    name3<-paste("clusNR", cols_to_cluster[a],sep="_")
    #top mir list
    top_rec_total<-unique(dplyr::select(temp,1))
    names(top_rec_total)[1]<-name1
    x<- list(top_rec, top_rec_total)
    invisible(utils::capture.output(top_rec<-cbind_filler(x)))
    #add to output
    name2<-paste("clus", cols_to_cluster[a],sep="_")
    temp3<-dplyr::select(input,3)
    names(temp3)[1]<-name1
    temp_log<- temp3[,1] %in% c('cl1', 'cl2')
    summary(temp_log)
    output[,name2]<-as.character(temp_log)
    output[,name3]<-as.character(paste(input$cluster))

    #check clusters###
    dat1<-subset(output, output[,name3]=='cl1')
    dat2<-subset(output, output[,name3]=='cl2')

    x<- (nrow(dat1)*100/nrow(output))
    x<-round(x)
    y<- (nrow(dat2)*100/nrow(output))
    y<-round(y)


    print(paste("in the column ", cols_to_cluster[a],
                ": cl1=", x, "% ", nrow(dat1), " rows",
                ": cl2=", y, "% ", nrow(dat2), " rows",
                sep=""))

  }


  return(output)
}
