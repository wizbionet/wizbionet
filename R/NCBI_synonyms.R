#' @export
#function
NCBI_synonyms<-function(inputDF, input_col){


#NCBI_synonyms example####

  # inputDF<- data.frame( symbols=c('ONECUT2','NEBL','SNTB2','USP9Y','KAT6A','CRIM1','IGSF10'), values=c(0.01,0.5,0.05,0.001,0.9,0.03,0.06))
  # input_col<- "symbols"
  # output<-NCBI_synonyms(inputDF, input_col)
  #names(output)


# import Homo sapiens file####
  #options(stringsAsFactors = FALSE)
  print(paste("importing uncollapsed Homo_sapiens annotation file. Original file source: ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz"))
  utils::data(Homo_sapiens, package = 'wizbionet')
  #devtools::use_data('./data/Homo_sapiens_uncoll_Jun2020.rda')
  Homo_sapiens<-wizbionet::NoNA.df(Homo_sapiens)
  Homo_sapiens <- Homo_sapiens[order(Homo_sapiens$Symbol),]

                      Homo_sapiens<- dplyr::mutate_all(Homo_sapiens, as.character)
                      names(Homo_sapiens)

                      Homo_sapiens_uncoll<-Homo_sapiens
                      Homo_sapiens_uncoll<-as.data.frame(Homo_sapiens_uncoll)


  #homo sapiens split###

             names(inputDF)
              output=inputDF
              row.names(output)<-NULL
              output[,input_col]<-as.character(output[,input_col])
              records<-col_to_string(output[,input_col]) #gene name
                output$SymbolNCBI<-NA
                output$EntrezID<-NA
                output$ENSG_ID<-NA
                output$description<-NA
                output$control<-NA

for(a in 1: length(records)){ #2
              print(paste('gene', records[a], 'nr', a , 'from', length(records)))
              record<-paste("^", records[a], "$" ,sep="" )

              temp_log <-grepl(record, Homo_sapiens_uncoll$all_synonyms)
              temp<-subset(temp_log, temp_log==TRUE)
              #present in NCBI####
                  if(length(temp)>0){#3 #present in official symbol
                 #select right version
                  temp1<-subset(Homo_sapiens_uncoll, temp_log==TRUE)
                  temp1$log<-temp1$Symbol %in% records[a]
                  temp1 <- temp1[order(temp1$log, decreasing = TRUE),]
                 #
                  names(temp1)
                  oficial_symbol<-as.character(temp1[1,2])
                  output[,'SymbolNCBI'][output[,input_col] == as.character(temp1[1,3])] <- oficial_symbol
                  output[,'control'][output[,input_col] == as.character(temp1[1,3])] <- "NCBI"
                  #entrez
                        entrez_id<-as.character(temp1[1,4])
                        output[,'EntrezID'][output[,input_col] == as.character(temp1[1,3])] <- entrez_id
                  #ensg
                        ENSG_id<-as.character(temp1[1,5])
                        output[,'ENSG_ID'][output[,input_col] == as.character(temp1[1,3])] <- ENSG_id



                  }#3

              #not present in NCBI
                  if(length(temp)<1){#4 #not present in official symbol
                    output[,'SymbolNCBI'][output[,input_col] == records[a]] <- records[a]
                    output[,'control'][output[,input_col] ==  records[a]] <- "input"

                    #entrez
                    #entrez_id<-as.character(temp1[1,4])
                     output[,'EntrezID'][output[,input_col] ==  records[a]] <- NA
                    #ensg
                    #ENSG_id<-as.character(temp1[1,5])
                     output[,'ENSG_ID'][output[,input_col] ==  records[a]] <- NA
                                    }#4


}#2

          output$description<-NULL
          output$control<-NULL

 names(output)





return(output)

}
