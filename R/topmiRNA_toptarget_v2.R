#' @import multiMiR
#' @export
topmiRNA_toptarget<-function(DEmir_up,DEgenes_down,DEmir_down, DEgenes_up, multimir_args, mirna_type){


  require(multiMiR)
  print(paste(
    "mirna_type can be \"mature_mir\" or \"premir\", mirna_type will be used for data aggregation "

  ))
  print(paste("see all multimir arguments using: as.list(args(multiMiR::get.multimir))"))
  print(paste("don't define parameters mirna= and target=, you already defined it in DEmir_up=,DEgenes_down=,DEmir_down=, DEgenes_up= "))
  #Example###

  # DEmir_up<-c('hsa-miR-150-5p','hsa-miR-448-5p','hsa-miR-448-3p','hsa-miR-493-5p','hsa-miR-493-3p') #example DE miRNAs
  # DEgenes_down<-c('5797','8826','7994','2775','7182','79647','5733','158158','9480','8626','50636') # example DE genes
  # DEmir_down<-c('hsa-miR-4731-5p','hsa-miR-541-3p','hsa-miR-449b-5p','hsa-miR-541-5p')
  # DEgenes_up<-c('203859','4745','4916','126298','2258','8464','55917','23450','29767')
  # aggregation=TRUE
  # multimir_args= list(url = NULL,
  #                     org = "hsa",
  #                     table = "all",
  #                     predicted.cutoff = 10,
  #                     predicted.cutoff.type = "p",
  #                     predicted.site = "conserved"
  # )
  #
  # #execute function
  # output<- topmiRNA_toptarget(DEmir_up,DEgenes_down,DEmir_down, DEgenes_up, multimir_args)
  #temp<- output$multimir_output
  #temp<- output$top_miR
if(missing(multimir_args)){
  multimir_args= list(url = NULL,
                      org = "hsa",
                      table = "all",
                      predicted.cutoff = 10,
                      predicted.cutoff.type = "p",
                      predicted.site = "conserved"
  )
}

  #function###

  multimir_outputs<-list()

  db.ver = multiMiR::multimir_dbInfoVersions()
  db.tables = multiMiR::multimir_dbTables()
  print(paste("multimiR", 'updated:' , db.ver[1,2]))
  multiMiR::multimir_switchDBVersion(db_version = db.ver[1,1])
  gc()


  #1 get.multimir parameters for multiMiR_DEmir_up_DEgenes_down####
  print(paste("screening DEmir_up and DEgenes_down"))
  mirnas= DEmir_up
  targets= DEgenes_down

  #multimir_args2<- as.list(args(multiMiR::get.multimir))
  multimir_args2<-multimir_args
  multimir_args2$mirna<-mirnas
  multimir_args2$target<- targets
  multimir_args2$url<-NULL
  multiMiR_DEmir_up_DEgenes_down <- do.call(multiMiR::get_multimir, multimir_args2)


  #2 get.multimir parameters for multiMiR_DEmir_down_DEgenes_up####
  print(paste("screening DEmir_down and DEgenes_up"))
  mirnas= DEmir_down
  targets= DEgenes_up
  multimir_args2<-multimir_args
  multimir_args2$mirna<-mirnas
  multimir_args2$target<- targets
  multimir_args2$url<-NULL
  multiMiR_DEmir_down_DEgenes_up <- do.call(multiMiR::get_multimir, multimir_args2)



  #3 merging results####
  data_DEmir_up_DEgenes_down<-multiMiR_DEmir_up_DEgenes_down@data
  data_DEmir_up_DEgenes_down<-NoNA.df(data_DEmir_up_DEgenes_down)
  data_DEmir_up_DEgenes_down<-subset(data_DEmir_up_DEgenes_down,!is.na(data_DEmir_up_DEgenes_down$target_symbol))
  data_DEmir_up_DEgenes_down<-unique(data_DEmir_up_DEgenes_down)


  data_DEmir_up_DEgenes_down<-unique(data_DEmir_up_DEgenes_down)
  x<-nrow(data_DEmir_up_DEgenes_down)
  if(x>0) {
    #data_DEmir_up_DEgenes_down<-subset(data_DEmir_up_DEgenes_down, database!='phenomir')
    data_DEmir_up_DEgenes_down$multimir<-'data_DEmir_up_DEgenes_down'
  }
  # summary_DEmir_up_DEgenes_down<-multiMiR_DEmir_up_DEgenes_down@summary
  # queries_DEmir_up_DEgenes_down<-multiMiR_DEmir_up_DEgenes_down@queries
  #

  data_DEmir_down_DEgenes_up<-as.data.frame(multiMiR_DEmir_down_DEgenes_up@data)
  data_DEmir_down_DEgenes_up<-NoNA.df(data_DEmir_down_DEgenes_up)
  data_DEmir_down_DEgenes_up<-subset(data_DEmir_down_DEgenes_up,!is.na(data_DEmir_down_DEgenes_up$target_symbol))
  data_DEmir_down_DEgenes_up<-unique(data_DEmir_down_DEgenes_up)

  rm(x)

  x<- suppressWarnings(as.numeric(nrow(data_DEmir_down_DEgenes_up)))
  if (x !=0){
    data_DEmir_down_DEgenes_up<-NoNA.df(data_DEmir_down_DEgenes_up)
    #data_DEmir_down_DEgenes_up<- subset(data_DEmir_down_DEgenes_up, database!='phenomir')
    data_DEmir_down_DEgenes_up$multimir<-'data_DEmir_down_DEgenes_up'

  }

  #6 generate pre mir####
  names(data_DEmir_up_DEgenes_down)
  names(data_DEmir_down_DEgenes_up)
  temp<-plyr::rbind.fill(data_DEmir_up_DEgenes_down, data_DEmir_down_DEgenes_up)
  temp<-NoNA.df(temp)
  temp<-subset(temp, !is.na(temp$mature_mirna_acc))
  temp<-unique(temp)
  multimir_output<-temp

  temp1<-gsub('*\\-5p',"",  multimir_output$mature_mirna_id)
  temp1<-gsub('*\\-3p',"" , temp1)
  multimir_output[,"premir"]<-temp1





  #7 data aggregation of the top_mir mirna_type-gene####
  print(paste('aggregating data to find top miRNA'))

  names(multimir_output)
  inputDF<-multimir_output
  col_names<- c("mature_mirna_acc", "mature_mirna_id" , "target_symbol"  ,  "target_entrez"  ,"target_ensembl" ,  "type" ,"multimir"  )
  #if pre_mir or mature_mir
  if(mirna_type=='pre_mir'){control_col <- "multimir"
  col_collapse<-"premir" #"premiR" mirna_type=c("mature_mirna_id", 'premir')
  rows_collapse<-col_to_string(inputDF[,"premir"])
  control_col <- "multimir"
  }

  if(mirna_type=='mature_mir'){control_col <- "multimir"
  col_collapse<-"mature_mirna_id" #"premiR" mirna_type=c("mature_mirna_id", 'premir')
  rows_collapse<-col_to_string(inputDF[,"mature_mirna_id"])
  control_col <- "multimir"
  }

  #aggregate
  temp1<-col_agrecounter(inputDF, col_names, col_collapse, rows_collapse, control_col)
  names(temp1)


  print(paste("OneR clustering data to find top miRNA"))

  #7a OneR clustering data to find top miRNA####
  inputDF<- temp1
  name_input_df="top_miRNA"
  if(mirna_type=='pre_mir'){
    landmark_col<- "premir"}
  if(mirna_type=='mature_mir'){
    landmark_col<- "mature_mirna_id"}

  cols_to_cluster<- "target_symbol_COUNT"
  names(inputDF)

 temp1<-  suppressWarnings(clusterizer_oneR(inputDF, landmark_col, cols_to_cluster))
 temp1<- top_percent(temp1, landmark_col, cols_to_cluster)
  names(temp1)

  if(mirna_type=='pre_mir'){
    x<- "premir"
    a<-paste("*",x, "", sep="")}
  if(mirna_type=='mature_mir'){
    x<- "mature_mirna_id"
    b<-paste("*",x, "", sep="")
  }


  #
  y=c(x , "premir", 'mature_mirna_id*' ,"multimir_coll" ,"mature_mirna_acc"  , "^target_symbol_coll", "^target_symbol_COUNT",  "type_coll" ,"type_COUNT","clus_target_symbol_COUNT",   "clusNR_target_symbol_COUNT" ,"clus25p_target_symbol_COUNT")
  temp1<-  col_selector(temp1, key_words=y )
  temp1<-unique(temp1)
  names(temp1)
  temp1 <- temp1[, !duplicated(colnames(temp1), fromLast = FALSE)]

  temp1 <- temp1[order(temp1$target_symbol_COUNT, decreasing = TRUE),]
  temp1$mature_mirna_acc_coll<-NULL
  temp1$mature_mirna_acc_COUNT<-NULL
  top_miR<-temp1
  names(top_miR)





  #8 data aggregation top_gene gene-mirna_type##############################
  print(paste('aggregating data to find top mRNA'))

  names(multimir_output)
  inputDF<-multimir_output
  col_names<- c("target_symbol", "target_entrez"  ,"target_ensembl", "mature_mirna_acc", "mature_mirna_id" ,"premir" , "type" ,"multimir"  )
  col_collapse<-"target_symbol"
  rows_collapse<-col_to_string(inputDF$target_symbol)
  control_col <- "multimir"

  temp1<-col_agrecounter(inputDF, col_names, col_collapse, rows_collapse, control_col)
  names(temp1)


  print(paste("OneR clustering data to find top mRNA"))
  #8a OneR clustering data to find top mRNA####
  rm(cols_to_cluster)
  inputDF<- temp1
  name_input_df="top_mRNA"
  landmark_col<- "target_symbol"
  cols_to_cluster<- c("mature_mirna_id_COUNT","premir_COUNT" ) #names(inputDF)[22]
  names(inputDF)

  temp2<-  suppressWarnings(clusterizer_oneR(inputDF,landmark_col, cols_to_cluster))
  temp2<- top_percent(temp2, landmark_col, cols_to_cluster)
  names(temp2)
  #
  if(mirna_type=='pre_mir'){
    x<- "premir"
    x<-paste("*",x, "_", sep="")}
  if(mirna_type=='mature_mir'){
    x<- "mature_mirna_id"
    x<-paste("*",x, "_", sep="")}
  y<- c("target_symbol$" , "target_entrez$", "target_ensembl_coll"  , x )
  temp1<-  col_selector(temp2, key_words=y )
  names(temp1)
  temp1<-unique(temp1)
  temp1 <- temp1[order(temp1[,5], decreasing = TRUE),]
  top_gene<-temp1
  names(top_gene)


  #9 save output ########
  multimir_outputs[['multimir_output']]<-multimir_output
  multimir_outputs[['top_miR']]<-top_miR
  multimir_outputs[['top_gene']]<-top_gene

  #print(paste("returning target predictions as list"))


  print(paste("                   Please cite creators of multiMiR", 'doi: 10.1093/nar/gku631', sep=" "))
  print(paste("                   Please cite creator of this package: Wicik Z."))



  return(multimir_outputs)


}#end of function




