#' @export
col_agrecounter<-function(inputDF, col_names, col_collapse , rows_collapse, control_col)
  {

  #example

  #create dataframe for aggegation and counting (A&C)###
  # dat1<- data.frame(
  #   mature_miRNA=c('hsa-miR-195-5p', 'hsa-miR-195-3p','hsa-miR-195-5p', 'hsa-miR-195-5p', 'hsa-miR-4753-5p', 'hsa-miR-4753-3p'),
  #   pre_miRNA=c('hsa-miR-195', 'hsa-miR-195','hsa-miR-195', 'hsa-miR-195', 'hsa-miR-4753', 'hsa-miR-4753'),
  #   Target=c('CDH24',	'PAX1',	'PTGER3',	'ONECUT2',	'TGFB3',	'FGFR1'),
  #   top=c(TRUE,TRUE,FALSE,TRUE,FALSE,TRUE),
  #   other=c(0.01,0.04,0.5,0.06, 0.3 ,0.01)
  # )
  # names(dat1)
  #
  # #set parameters####
  # inputDF<-dat1 #dataframe for aggegation and counting (A&C)
  # col_names <- c( "Target" , "top"  ) #selected column names which will be A&C
  # col_collapse <- "pre_miRNA"  #landmark column for A&C columns, other columns will be aggregated based on this
  # rows_collapse <-col_to_string(inputDF$pre_miRNA)  # content of the column  landmark column all_of(col_collapse) as vector. You can use internal col_to_string function
  # control_col<- "mature_miRNA"# additional landmark column which will not allow to de-duplicate
  #
  # temp<- col_agrecounter(inputDF, col_names, col_collapse , rows_collapse, control_col)
  #





print(  'inputDF- dataframe for aggegation and counting (A&C)')
print(   'col_names- column names which will be A&C')
print( 'col_collapse- landmark column for A&C columns')
print( 'rows_collapse- content of the column  landmark column all_of(col_collapse) as vector ')
print( 'control_col- additional landmark column')

#remove NA

inputDF<-NoNA.df(inputDF)

  output<-inputDF
  output$control<- NA
#loop

b=1
col_names<-subset(col_names, col_names!=tidyselect::all_of(col_collapse))
  for(a in 1:length(rows_collapse)){

    input<-subset(inputDF, inputDF[,tidyselect::all_of(col_collapse)]==rows_collapse[a])

    for(b in 1:length(col_names)){#2
      #add column
      name1<-paste(col_names[b], "_coll", sep='')
      name2<-paste(col_names[b], "_COUNT", sep='')
      temp_log<-name1 %in% names(output)

      #
      if(temp_log==FALSE){
        output[,name1]<-NA

      }
      #
      temp_log<-name2 %in% names(output)

      if(temp_log==FALSE){
        output[,name2]<-NA

      }
      name1<-paste(col_names[b], "_coll", sep='')
      name2<-paste(col_names[b], "_COUNT", sep='')

      names(output)
      names(input)
      temp1<-dplyr::select(input, tidyselect::all_of(col_collapse), col_names[b], tidyselect::all_of(control_col))
      temp1<-unique(temp1)
      temp1[,2]<-as.character(temp1[,2])
      temp1<-subset(temp1, !is.na(temp1[,2]))
      temp2<-nrow(temp1)
      #coll

      #put collapse
      temp1<-as.vector(temp1[,2])
      temp1<-sort(temp1, decreasing = FALSE)
      temp1<- paste(temp1,collapse="|")
      output[,name1][output[,tidyselect::all_of(col_collapse)]==rows_collapse[a]]<-temp1
      output[,name2][output[,tidyselect::all_of(col_collapse)]==rows_collapse[a]]<-temp2
      output[,'control'][output[control_col]==rows_collapse[a]]<-rows_collapse[a]
      #put counts
      print(paste( rows_collapse[a], 'count:',temp2, col_names[b] ))

    }}   #1
  output<-NoNA.df(output)
  output$control
  output_count<-output
  output_count<-unique(output_count)
  output_count <- output_count[order(output_count[,tidyselect::all_of(control_col)]),]

  return(output_count)

}

