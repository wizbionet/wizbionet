#' @export


lists.combiner<-function(inputDF){
  #This function combines multiple gene lists together and summarizes occurence of the string within a list. Gene lists which will be combined should be a data frame (inputDF) of multiple gene/miRNAslists. Gene list in inputDF don't need to have equal lenght

 #example:
  # options(stringsAsFactors = FALSE)
  # GeneList1=c('PTGER3','FGFR1','ANO5','SGCD','CCKBR','PTGFR','NELL1','TBC1D8B','TGFB3')
  # GeneList2=c('CDH24','PAX1','PTGER3','TBC1D8B','TGFB3','PTGER3','NR2C2','NR2C2')
  # GeneList3=c('PTGER3','FGFR1','ONECUT2','NEBL','SNTB2','USP9Y','KAT6A','CRIM1','IGSF10','PRKDC','RAD23B','BRD1','PTPRM','PTGIS','RGS5','XIRP1','SPSB4')
  # GeneList4=c('PTGER3','FGFR1','GLIPR1','BCR','SMARCA2','MSMO1','FGF13','KALRN')
  #x<-list(GeneList1,	GeneList2, GeneList3,	GeneList4)
  # inputDF<- cbind_filler	(x)
  # names(inputDF)<-c('GeneList1',	'GeneList2', 'GeneList3',	'GeneList4' )
  # #run function
  # output<- lists.combiner(inputDF)



  print(paste("gene lists in inputDF don't need to have equal lenght or be deduplicated"))

  #options(stringsAsFactors = FALSE)
  inputDF [inputDF ==""] <- NA
  inputDF<-unique(inputDF)
  inputDF [inputDF ==""] <- NA

  names_inputDF<- names(inputDF)
  i=3
  Symbol<-NULL
  Symbol<-as.character(Symbol)
  for (i in 1:length(inputDF )){
    temp<- inputDF [,i]
    temp<-as.data.frame(temp)
    temp<-unique(temp)
    temp<-subset(temp, !is.na(temp))

    temp<-as.character(temp[,1])
    Symbol<-union(Symbol, temp)

    Symbol<-unique(Symbol)
  }
  all_inputDF<- Symbol
  names(all_inputDF)<-'Symbol'
  rm(Symbol)

  input<-all_inputDF
  input<-as.data.frame(input)

  for (i in 1:length(inputDF )){
    temp<- inputDF [,i]
    temp<-as.data.frame(temp)
    temp<-unique(temp)
    temp<-subset(temp, !is.na(temp))
    vec<-as.character(temp$temp)
    temp_log<- input$input %in% vec


    summary(temp_log)
    temp_log<-as.data.frame(temp_log)
    names(temp_log)<-names_inputDF[i]
    input<-cbind(input, temp_log)

  }
  input<-unique(input) #end of loop
  input<-unique(input)
  result_lists_combiner<-input
  result_lists_combiner$count<-rowSums(result_lists_combiner[,2:length(result_lists_combiner)]==TRUE )
  result_lists_combiner <- result_lists_combiner[order(result_lists_combiner$count, decreasing = TRUE),]


  print(paste("done :)" ))

  return(result_lists_combiner)






} #end of function



