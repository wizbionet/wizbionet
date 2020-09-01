
#' @export
#'
#'
lnc_RNARNA_scanner <-function(ENST_input, analyze_onlyDEtargets, ENST_targets ,nr_top_genes  )
{


if(missing(nr_top_genes)){
  nr_top_genes<-500
}
  gc()

  #input explanation
  print(paste("Input explanation:"))
  print(paste("1. ENST_input            = ENST transcript numbers. RNARNAdb will automaticly recognize lncRNAs"))
  print(paste("2. analyze_onlyDEtargets = logical, do you want to check all possible targets or only DE targets?"))
  print(paste("3. ENST_targets = ENST numbers of targets of your interest, usually DE mRNAs"))
  print(paste("4. nr_top_genes          = number of top targets from RNARNA databse output"))



#Function###
i=2
lnc_RNAtoRNA_<-list()
id_results<-list()
input<-ENST_input

i=5

#loop#
for (i in 1:length(input)){
  temp<-input[i]
  id<-temp
  #rm()
  query_min<-paste("http://rtools.cbrc.jp/cgi-bin/RNARNA/_createRankedHTML_bin.pl?gene=", id, "&to=", nr_top_genes, "&rmeth=min&fm=1&submit=submit", sep="")
  query_sum<-paste("http://rtools.cbrc.jp/cgi-bin/RNARNA/_createRankedHTML_bin.pl?gene=", id, "&to=", nr_top_genes,"&rmeth=sum&fm=1&submit=submit", sep="")
  #print(paste(id, "; number: " ,i, " from ", length(input) , sep=''))

  #id full
  name_minEnergy.table<-readLines(query_min)
  name_minEnergy.table<-name_minEnergy.table[3]
  name_minEnergy.table <- as.data.frame(sapply(name_minEnergy.table, function(x) gsub("<H4>", "", x)))
  name_minEnergy.table <- as.data.frame(sapply(name_minEnergy.table, function(x) gsub("</H4>", "", x)))
  name_minEnergy.table<-as.character(name_minEnergy.table[,1])

  name_sumEnergy.table<-readLines(query_sum)
  name_sumEnergy.table<-name_sumEnergy.table[3]
  name_sumEnergy.table <- as.data.frame(sapply(name_sumEnergy.table, function(x) gsub("<H4>", "", x)))
  name_sumEnergy.table <- as.data.frame(sapply(name_sumEnergy.table, function(x) gsub("</H4>", "", x)))
  name_sumEnergy.table<-as.character(name_sumEnergy.table[,1])

  Error_min<- grepl("ERR", name_minEnergy.table)
  Error_sum<- grepl("ERR", name_sumEnergy.table)
  x<- ifelse(Error_min==FALSE, 'yes', 'no')
  print(paste(id, "; transcript: " ,i, " from ", length(input) , " |", " was found in database?: ", x, sep=''))
  #deal with errors
  if(Error_min==FALSE){

    minEnergy.table = XML::readHTMLTable(query_min, header=T, which=1,stringsAsFactors=F)
    sumEnergy.table = XML::readHTMLTable(query_sum, header=T, which=1,stringsAsFactors=F)
    exist_minEnergy.table <-exists("minEnergy.table")
    exist_sumEnergy.table <-exists("sumEnergy.table")

    names(minEnergy.table)<-c('Rank',	'Ensemble_ID'	,'Name',	'Position_hg19','MinEnergy','Binding_site_query',	'Binding_site_target',	'location','SumEnergy')
    names(sumEnergy.table)<-c('Rank',	'Ensemble_ID'	,'Name',	'Position_hg19','MinEnergy','Binding_site_query',	'Binding_site_target',	'location','SumEnergy')
    name_minEnergy<-paste(id ,'minEnergy', sep='_')
    name_sumEnergy<-paste(id ,'sumEnergy', sep='_')


    minEnergy.table$full_id<-name_minEnergy.table
    sumEnergy.table$full_id<-name_sumEnergy.table
    #rm(id_results)
    id_results<-list()
    id_results[[name_minEnergy]]<-minEnergy.table

    id_results[[name_sumEnergy]]<-sumEnergy.table
    name1<-paste(id, 'results', sep='_')


    lnc_RNAtoRNA_[[name1]]<-id_results

  }



  ##rm(minEnergy.table,sumEnergy.table, exist_minEnergy.table , exist_sumEnergy.table,Error_min,Error_sum, id_results)
}


#result all targets befor aggregation
result_lnc_RNAtoRNA_list<-lnc_RNAtoRNA_
lncRNA_scanner_result<-list()



#return(result_lnc_RNAtoRNA_list<-lnc_RNAtoRNA_)



#Overlap lncRNA_AllTargets####
#analyze_onlyDEtargets==FALSE : Overlap lncRNA_AllTargets####
if(analyze_onlyDEtargets==FALSE){#A
  names_list<- names(lnc_RNAtoRNA_)
  lnc_RNAtoRNA_overlap<-list()
  i=1
  input<-lnc_RNAtoRNA_




  #loop
  for (i in 1:length(input)){#B
    #rm(combined_overlap,min_rows,sum_rows,id_results,name_minEnergy,name_sumEnergy,name_MinSumEnergy)
    temp<-input[[i]]
    name1<-names_list[i]
    #id
    id<-name1
    id<- as.data.frame(sapply(id, function(x) gsub("_results", "", x)))
    id<-as.character(id[,1])
    #unlist min_tab
    min_tab<-temp[1]
    temp1<-do.call(rbind.data.frame, min_tab)
    if(i==1){
      empty_df=temp1[FALSE,]
      combined_overlap.tab = empty_df[FALSE,]
    }
    #unlist min_tab
    sum_tab<-temp[2]
    temp2<-do.call(rbind.data.frame, sum_tab)

    #overlap between min_tab and sum_tab


    min_overlap <- temp1[temp1[,2] %in% temp1[,2], ]
    sum_overlap <- temp2[temp2[,2] %in% temp2[,2], ]
    if(nrow(min_overlap)>0){
      min_overlap$target_source<-"minEnergy"
      rownames(min_overlap)<-NULL
    }

    if(nrow(sum_overlap)>0){
      sum_overlap$target_source<-"sumEnergy"
      rownames(sum_overlap)<-NULL
    }



    #rbind
    combined_overlap<-rbind(min_overlap,sum_overlap )
    combined_overlap<-unique(combined_overlap)
    min_rows<-nrow(min_overlap)
    sum_rows<-nrow(sum_overlap)

    #add to list 1
    name_minEnergy<-paste(id ,'minEnergy', sep='_')
    name_sumEnergy<-paste(id ,'sumEnergy', sep='_')
    name_MinSumEnergy<-paste(id ,'MinSumEnergy', sep='_')
    #rm(id_results)
    id_results<-list()
    id_results[[name_minEnergy]]<-min_overlap
    id_results[[name_sumEnergy]]<-sum_overlap
    id_results[[name_MinSumEnergy]]<-combined_overlap
    print(paste(id , "; number: " ,i, " from ", length(input) , sep=''))

    name1<-paste(id, 'results', sep='_')
    print(paste(name1 , "; number: " ,i, " from ", length(input) , sep=''))
    lnc_RNAtoRNA_overlap[[name1]]<-id_results


    #table with noncoding
    temp1<-combined_overlap
    temp1$nc_id<-id

    combined_overlap.tab1<-temp1
    combined_overlap.tab<-rbind(combined_overlap.tab,combined_overlap.tab1)
    ##rm(combined_overlap,min_rows,sum_rows,id_results,name_minEnergy,name_sumEnergy,name_MinSumEnergy)

    names(combined_overlap.tab)
  }#B

  #combined_overlap.tab$Rank<-NULL
  combined_overlap.tab<-unique(combined_overlap.tab)
  lncRNA_scanner_result[['lncRNA_AllTargets']]<-combined_overlap.tab


}#C



#Overlap lncRNA_DEtarget
#analyze_onlyDEtargets==TRUE: Overlap lncRNA_DEtarget####

if(analyze_onlyDEtargets==TRUE){#A
      names_list<- names(lnc_RNAtoRNA_)
      lnc_RNAtoRNA_overlap<-list()
      i=1
      input<-lnc_RNAtoRNA_



      #input<-head(lnc_RNAtoRNA_, n=5)
      #loop
      for (i in 1:length(input)){#B
        #rm(combined_overlap,min_rows,sum_rows,id_results,name_minEnergy,name_sumEnergy,name_MinSumEnergy)
        temp<-input[[i]]
        name1<-names_list[i]
        #id
        id<-name1
        id<- as.data.frame(sapply(id, function(x) gsub("_results", "", x)))
        id<-as.character(id[,1])
        #unlist min_tab
        min_tab<-temp[1]
        temp1<-do.call(rbind.data.frame, min_tab)
        if(i==1){
          empty_df=temp1[FALSE,]
          combined_overlap.tab = empty_df[FALSE,]
        }
        #unlist min_tab
        sum_tab<-temp[2]
        temp2<-do.call(rbind.data.frame, sum_tab)

        #overlap between min_tab and sum_tab


        min_overlap <- temp1[temp1[,2] %in% ENST_targets, ]
        sum_overlap <- temp2[temp2[,2] %in% ENST_targets, ]
        if(nrow(min_overlap)>0){
        min_overlap$target_source<-"minEnergy"
        rownames(min_overlap)<-NULL
        }

        if(nrow(sum_overlap)>0){
        sum_overlap$target_source<-"sumEnergy"
        rownames(sum_overlap)<-NULL
        }



        #rbind
        combined_overlap<-rbind(min_overlap,sum_overlap )
        combined_overlap<-unique(combined_overlap)
        min_rows<-nrow(min_overlap)
        sum_rows<-nrow(sum_overlap)

        #add to list 1
        name_minEnergy<-paste(id ,'minEnergy', sep='_')
        name_sumEnergy<-paste(id ,'sumEnergy', sep='_')
        name_MinSumEnergy<-paste(id ,'MinSumEnergy', sep='_')
        #rm(id_results)
        id_results<-list()
        id_results[[name_minEnergy]]<-min_overlap
        id_results[[name_sumEnergy]]<-sum_overlap
        id_results[[name_MinSumEnergy]]<-combined_overlap
        print(paste(id , "; number: " ,i, " from ", length(input) , sep=''))

        name1<-paste(id, 'results', sep='_')
        print(paste(name1 , "; number: " ,i, " from ", length(input) , sep=''))
        lnc_RNAtoRNA_overlap[[name1]]<-id_results


        #table with noncoding
        temp1<-combined_overlap
        temp1$nc_id<-id

        combined_overlap.tab1<-temp1
        combined_overlap.tab<-rbind(combined_overlap.tab,combined_overlap.tab1)
        ##rm(combined_overlap,min_rows,sum_rows,id_results,name_minEnergy,name_sumEnergy,name_MinSumEnergy)

      names(combined_overlap.tab)

      }#B
      #combined_overlap.tab$Rank<-NULL
      combined_overlap.tab<-unique(combined_overlap.tab)
      lncRNA_scanner_result[['lncRNA_DEtargets']]<-combined_overlap.tab


      }#A

lncRNA_scanner_result[['result_lnc_RNAtoRNA_list']]<-result_lnc_RNAtoRNA_list













print(paste("Please cite creators of RNARNA database: doi: 10.1186/s12864-015-2307-5"))
print(paste("Please cite creator of this package: Wicik Z."))

print(paste("suggested next step: use function col_agrecounter"))


print(names(lncRNA_scanner_result))
return(lncRNA_scanner_result)


}
