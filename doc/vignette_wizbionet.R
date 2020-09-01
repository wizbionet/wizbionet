## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
  
)

## ----eval=FALSE, fig.width=10-------------------------------------------------
#  #Some of the dependencies are not downloaded automatically yet.
#  #Below is the code which will install all of them. Just copy it and paste to your R console
#  #dependencies
#        #dplyr (>= 1.0.2), multiMiR (>= 1.10.0),  stringr (>= 1.4.0),  XML (>= 3.99-0.5),
#        #OneR (>= 2.2.0), plyr (>= 1.8.6), tidyselect (>= 1.1.0), kableExtra (>= 1.1.0)
#  
#  
#  # 1. installation of the necessary packages, if it will not work download tar file from the webpage.If will not work download tar files and install them using command #   #
#  
#      #install.packages("path_to_the package")
#        if (!requireNamespace("BiocManager", quietly=TRUE))
#            install.packages("BiocManager")
#        BiocManager::install()
#        BiocManager::install("multiMiR")
#  
#      # https://cran.r-project.org/web/packages/OneR/index.html
#      install.packages("OneR", type = "binary")
#  
#      #https://cran.r-project.org/web/packages/kableExtra/
#      install.packages('kableExtra',  type = "binary")
#  
#  
#  # 2 A. You can  install package wizbionet from the GitHub use this command:
#      install.packages("remotes")
#      remotes::install_github("wizbionet/wizbionet", dependencies ="Depends")
#  
#  # 2 B.Or install wizbionet from the wizbionet_0.99.0.tar.gz file downloaded from this link:
#      #https://github.com/wizbionet/wizbionet/raw/master/wizbionet_0.99.0.tar.gz
#  
#      install.packages("https://github.com/wizbionet/wizbionet/raw/master/wizbionet_0.99.0.tar.gz",
#                   repos = NULL, type = "source",
#                   dependencies =TRUE
#                   )
#  
#  #Voila, load the package:
#  library(wizbionet)

## ---- eval= FALSE-------------------------------------------------------------
#  # genelistGWAS<- readClipboard()
#  # genelistGO<- readClipboard()
#  # genelistKEGG<- readClipboard()

## ---- eval= FALSE-------------------------------------------------------------
#  genelistGWAS<- as.data.frame(genelistGWAS)
#  NCBI_synonyms(genelistGWAS, "genelistGWAS")

## ---- echo=FALSE--------------------------------------------------------------

invisible(capture.output(dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'EP3', 'ANO5', 'FGFR1', 'PTGFR','SNT3', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))))
invisible(capture.output(output<- wizbionet::NCBI_synonyms(dat1, 'genelistGWAS')))

temp<-kableExtra::kable_styling(knitr::kable(output, align="l"),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white")
temp<-kableExtra::column_spec(temp, column=2, color='red')
temp


## ---- eval= FALSE-------------------------------------------------------------
#  col_selector(genelistGWAS, key_words = "SymbolNCBI")
#  #Use Regular Expression Syntax (https://rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf) to precisely select columns:
#  #Meta characters . * +
#  #Anchors: ^ Start of the string; $ End of the string

## ---- eval= FALSE-------------------------------------------------------------
#  output<- cbind_filler(list(genelistGWAS,genelistGO,genelistKEEG))

## ---- eval= FALSE-------------------------------------------------------------
#  names(output)<-c('genelistGWAS','genelistGO','genelistKEEG')

## ---- eval= FALSE-------------------------------------------------------------
#  output<- cbind_filler(output)

## ---- echo=FALSE--------------------------------------------------------------

dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat2<- data.frame(genelistGO=c('CDH24', 'ONECUT2', 'NEBL', 'KAT6A', 'PTGER3', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat3<- data.frame(genelistKEGG=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR', 'NELL1', 'NR2C2', 'TGFB3', 'BRD1', 'RAD23B', 'PRKDC', 'IGSF10', 'AKIRIN1', 'HACD4', 'C4orf32'))
input<- list(dat1,dat2,dat3)

invisible(capture.output(output<- wizbionet::cbind_filler(input)))
rownames(output)<-NULL



kableExtra::kable_styling(knitr::kable(output, align="l"),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white",
                      )

## ---- eval= FALSE-------------------------------------------------------------
#  output<- lists.combiner(output)
#  head(output, n=15)

## ---- echo=FALSE--------------------------------------------------------------
dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat2<- data.frame(genelistGO=c('CDH24', 'ONECUT2', 'NEBL', 'KAT6A', 'PTGER3', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat3<- data.frame(genelistKEGG=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR', 'NELL1', 'NR2C2', 'TGFB3', 'BRD1', 'RAD23B', 'PRKDC', 'IGSF10', 'AKIRIN1', 'HACD4', 'C4orf32'))
input<- list(dat1,dat2,dat3)

invisible(capture.output(temp<- wizbionet::cbind_filler(input)))
invisible(capture.output(output<- wizbionet::lists.combiner(temp)))
rownames(output)<-NULL
temp<-kableExtra::kable_styling(knitr::kable(head(output,n=15)),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white",
                          )
temp<-kableExtra::column_spec(temp, column=5, color='red')

temp

## ---- eval= FALSE-------------------------------------------------------------
#  output<- NCBI_synonyms(output, "input")
#  head(output, n=10)

## ---- echo=FALSE--------------------------------------------------------------
dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat2<- data.frame(genelistGO=c('CDH24', 'ONECUT2', 'NEBL', 'KAT6A', 'PTGER3', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat3<- data.frame(genelistKEGG=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR', 'NELL1', 'NR2C2', 'TGFB3', 'BRD1', 'RAD23B', 'PRKDC', 'IGSF10', 'AKIRIN1', 'HACD4', 'C4orf32'))
input<- list(dat1,dat2,dat3)

invisible(capture.output(temp<- wizbionet::cbind_filler(input)))
invisible(capture.output(output<- wizbionet::lists.combiner(temp)))
invisible(capture.output(output<- wizbionet::NCBI_synonyms(output, "input")))
#head(output, n=15)

temp<-kableExtra::kable_styling(knitr::kable(head(output,n=10)),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white",
                          )
temp<-kableExtra::column_spec(temp, column=c(6,7,8), color='red')
temp

## ---- eval= FALSE-------------------------------------------------------------
#  landmark_col,="SymbolNCBI"
#  cols_to_cluster="count"
#  output<- clusterizer_oneR(output, landmark_col, cols_to_cluster)
#  head(output, n=10)

## ---- echo=FALSE--------------------------------------------------------------
dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat2<- data.frame(genelistGO=c('CDH24', 'ONECUT2', 'NEBL', 'KAT6A', 'PTGER3', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat3<- data.frame(genelistKEGG=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR', 'NELL1', 'NR2C2', 'TGFB3', 'BRD1', 'RAD23B', 'PRKDC', 'IGSF10', 'AKIRIN1', 'HACD4', 'C4orf32'))
input<- list(dat1,dat2,dat3)

invisible(capture.output(temp<- wizbionet::cbind_filler(input)))
invisible(capture.output(output<- wizbionet::lists.combiner(temp)))
invisible(capture.output(output<- wizbionet::NCBI_synonyms(output, "input")))

invisible(capture.output(output<- wizbionet::clusterizer_oneR(output, landmark_col="SymbolNCBI", cols_to_cluster="count")
  ))
output<-as.data.frame( output)
temp<-kableExtra::kable_styling(knitr::kable(head(output,n=15)),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left",                          )
temp<-kableExtra::column_spec(temp, column=c(9,10), color='red')
temp

## ---- eval= FALSE-------------------------------------------------------------
#  landmark_col,="SymbolNCBI"
#  cols_to_cluster="count"
#  cutoff=25
#  output<- clusterizer_oneR(output, landmark_col, cols_to_cluster, cutoff)
#  head(output, n=10)

## ---- echo=FALSE--------------------------------------------------------------
dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat2<- data.frame(genelistGO=c('CDH24', 'ONECUT2', 'NEBL', 'KAT6A', 'PTGER3', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat3<- data.frame(genelistKEGG=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR', 'NELL1', 'NR2C2', 'TGFB3', 'BRD1', 'RAD23B', 'PRKDC', 'IGSF10', 'AKIRIN1', 'HACD4', 'C4orf32'))
input<- list(dat1,dat2,dat3)

invisible(capture.output(temp<- wizbionet::cbind_filler(input)))
invisible(capture.output(output<- wizbionet::lists.combiner(temp)))
invisible(capture.output(output<- wizbionet::NCBI_synonyms(output, "input")))
invisible(capture.output(output<- wizbionet::top_percent(output, landmark_col="SymbolNCBI", cols_to_cluster="count", cutoff=25 )))
output<-as.data.frame( output)
temp<-kableExtra::kable_styling(knitr::kable(head(output,n=15)),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left",                          )
temp<-kableExtra::column_spec(temp, column=c(9), color='red')
temp

## ---- eval= FALSE-------------------------------------------------------------
#  dataframe_list=list('output'=output, 'other_dataframe'=other_dataframe)
#  ID_column="input"
#  dataframe.merger(dataframe_list,  ID_column="input")

## ---- eval= FALSE-------------------------------------------------------------
#  landmark_col="SymbolNCBI"
#  cols_to_cluster= c("count", 'count_regulatory_miRNA')
#  output<- clusterizer_oneR(output, landmark_col, cols_to_cluster)
#  head(output, n=10)

## ---- echo=FALSE--------------------------------------------------------------

dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat2<- data.frame(genelistGO=c('CDH24', 'ONECUT2', 'NEBL', 'KAT6A', 'PTGER3', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat3<- data.frame(genelistKEGG=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR', 'NELL1', 'NR2C2', 'TGFB3', 'BRD1', 'RAD23B', 'PRKDC', 'IGSF10', 'AKIRIN1', 'HACD4', 'C4orf32'))
input<- list(dat1,dat2,dat3)

invisible(capture.output(temp<- wizbionet::cbind_filler(input)))
invisible(capture.output(output<- wizbionet::lists.combiner(temp)))
invisible(capture.output(output<- wizbionet::NCBI_synonyms(output, "input")))
output<-output[,c("SymbolNCBI", "count")]
rownames(output)<-NULL
output$count_regulatory_miRNA<- rnorm(n=24, m=65, s=30)
output$count_regulatory_miRNA<- round(output$count_regulatory_miRNA)
landmark_col="SymbolNCBI" 
cols_to_cluster= c("count", 'count_regulatory_miRNA')
invisible(capture.output(output<- wizbionet::clusterizer_oneR(output, landmark_col, cols_to_cluster)))

temp<-kableExtra::kable_styling(knitr::kable(head(output,n=15)),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white",                          )
temp<-kableExtra::column_spec(temp, column=c(4,6), color='red')
temp




## ---- eval= FALSE-------------------------------------------------------------
#  #Example
#  dat1<- data.frame(
#    mature_miRNA=c('hsa-miR-195-5p', 'hsa-miR-195-3p','hsa-miR-195-5p', 'hsa-miR-195-5p',
#                   'hsa-miR-4753-5p', 'hsa-miR-4753-3p'),
#    pre_miRNA=c('hsa-miR-195', 'hsa-miR-195','hsa-miR-195', 'hsa-miR-195',
#                'hsa-miR-4753', 'hsa-miR-4753'),
#    Target=c('CDH24',	'PAX1',	'PTGER3',	'ONECUT2',	'TGFB3',	'FGFR1'))
#  
#  
#  #set parameters####
#  
#  #dataframe for aggegation and counting (A&C)
#      inputDF<-dat1
#  #selected column names which will be A&C
#      col_names <- c( "Target")
#  #landmark column for A&C columns,other columns will be aggregated based on this
#      col_collapse <- "pre_miRNA"
#  #vector of content of the landmark column "col_collapse" as vector.
#  #You can use internal col_to_string() function
#  
#      rows_collapse <-col_to_string(inputDF$pre_miRNA)
#  #additional landmark column which will not allow to deduplicate. useful when you want to analyze pre-miRNAs instead of mature mirNAs
#      control_col<- "mature_miRNA"
#  
#  #run function
#  output<- col_agrecounter(inputDF, col_names, col_collapse , rows_collapse, control_col)

## ---- echo= FALSE-------------------------------------------------------------
#Example
dat1<- data.frame(
  mature_miRNA=c('hsa-miR-195-5p', 'hsa-miR-195-3p','hsa-miR-195-5p', 'hsa-miR-195-5p',
                 'hsa-miR-4753-5p', 'hsa-miR-4753-3p'),
  pre_miRNA=c('hsa-miR-195', 'hsa-miR-195','hsa-miR-195', 'hsa-miR-195',
              'hsa-miR-4753', 'hsa-miR-4753'),
  Target=c('CDH24',	'PAX1',	'PTGER3',	'ONECUT2',	'TGFB3',	'FGFR1'))


#set parameters####

#dataframe for aggegation and counting (A&C)
    inputDF<-dat1 
#selected column names which will be A&C
    col_names <- c( "Target")
#landmark column for A&C columns,other columns will be aggregated based on this
    col_collapse <- "pre_miRNA"       
#vector of content of the landmark column "col_collapse" as vector. 
#You can use internal col_to_string() function
    
    rows_collapse <-wizbionet::col_to_string(inputDF$pre_miRNA)
#additional landmark column which will not allow to deduplicate. useful when you want to analyze pre-miRNAs instead of mature mirNAs
    control_col<- "mature_miRNA"

#run function    
output<- wizbionet::col_agrecounter(inputDF, col_names, col_collapse , rows_collapse, control_col)
#names(output)
temp<-kableExtra::kable_styling(knitr::kable(head(output,n=15)),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white",                          )
temp<-kableExtra::column_spec(temp, column=c(6,7), color='red')
temp

## ---- eval= FALSE-------------------------------------------------------------
#  output<-subset(output, output$clus_count==TRUE & output$clus_count_regulatory_miRNA==TRUE )

## ---- echo=FALSE--------------------------------------------------------------

dat1<- data.frame(genelistGWAS=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat2<- data.frame(genelistGO=c('CDH24', 'ONECUT2', 'NEBL', 'KAT6A', 'PTGER3', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC'))
dat3<- data.frame(genelistKEGG=c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR', 'NELL1', 'NR2C2', 'TGFB3', 'BRD1', 'RAD23B', 'PRKDC', 'IGSF10', 'AKIRIN1', 'HACD4', 'C4orf32'))
input<- list(dat1,dat2,dat3)
invisible(capture.output(temp<- wizbionet::cbind_filler(input)))
invisible(capture.output(output<- wizbionet::lists.combiner(temp)))
invisible(capture.output(output<- wizbionet::NCBI_synonyms(output, "input")))
output<-output[,c("SymbolNCBI", "count")]

output$count_regulatory_miRNA<- rnorm(n=24, m=65, s=30)
output$count_regulatory_miRNA<- round(output$count_regulatory_miRNA)
landmark_col="SymbolNCBI" 
cols_to_cluster= c("count", 'count_regulatory_miRNA')
invisible(capture.output(output<- wizbionet::clusterizer_oneR(output, landmark_col, cols_to_cluster)))
output<-subset(output, output$clus_count==TRUE & output$clus_count_regulatory_miRNA==TRUE ) 
rownames(output)<-NULL


temp<-kableExtra::kable_styling(knitr::kable(head(output,n=15)),font_size=9, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white",                          )
temp<-kableExtra::column_spec(temp, column=c(4,6), color='red')
temp

## ----topmiRNA_toptarget, eval= FALSE------------------------------------------
#  #generate and modify list of arguments. Important: Don't add mirna=  and  target= fields they are already included as DEmir_up,DEgenes_down,DEmir_down, DEgenes_up!
#  multimir_args<- as.list(args(multiMiR::get_multimir))
#  
#  #add lists of DE miRNAs and genes
#  DEmir_up<-c('hsa-miR-150-5p','hsa-miR-448-5p','hsa-miR-448-3p',
#              'hsa-miR-493-5p','hsa-miR-493-3p') # example DE miRNAs
#  DEgenes_down<-c('5797','8826','7994','2775','7182','79647','5733',
#                  '158158','9480','8626','50636') # example DE genes
#  DEmir_down<-c('hsa-miR-4731-5p','hsa-miR-541-3p','hsa-miR-449b-5p','hsa-miR-541-5p')
#  DEgenes_up<-c('203859','4745','4916','126298','2258','8464','55917','23450','29767')
#  mirna_type<-"pre_mir" # "mature_mir"
#  multimir_args= list(url = NULL,
#                      org = "hsa",
#                      table = "all",
#                      predicted.cutoff = 10,
#                      predicted.cutoff.type = "p",
#                      predicted.site = "conserved"
#  )
#  
#  #execute function
#  output<- topmiRNA_toptarget(DEmir_up,DEgenes_down,                                       DEmir_down, DEgenes_up, multimir_args,mirna_type)
#  
#  
#  #execute function
#  output<-wizbionet::topmiRNA_toptarget(DEmir_up,DEgenes_down,DEmir_down,
#                                        DEgenes_up, mir_type, multimir_args)
#  output$multimir_output
#  output$top_miR
#  output$top_gene

## ---- echo=FALSE--------------------------------------------------------------
utils::data(topmiRNA_toptarget_output, package = 'wizbionet')
output<-topmiRNA_toptarget_output$multimir_output
output<-head(output,n=15)

#table
temp<- knitr::kable(output, align="l")
temp<- kableExtra::kable_styling(temp,font_size=8, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white")
temp<-kableExtra::column_spec(temp, column=c(14,15),color="red")
temp<-kableExtra::scroll_box(temp, width = "100%", height = "200px")

temp


## ----topmiRNA_toptarget: top_miR, echo=FALSE----------------------------------
utils::data(topmiRNA_toptarget_output, package = 'wizbionet')
output<-topmiRNA_toptarget_output$top_miR
output<-head(output,n=15)
rownames(output)<-NULL
#names(output)
#table
temp<- knitr::kable(output, align="l")
temp<- kableExtra::kable_styling(temp,font_size=8, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white")
temp<-kableExtra::column_spec(temp, column=c(6,7,12,13), color = "red")
temp<-kableExtra::scroll_box(temp, width = "100%", height = "200px")

temp


## ----topmiRNA_toptarget: top_gene, echo=FALSE---------------------------------
utils::data(topmiRNA_toptarget_output, package = 'wizbionet')
output<-topmiRNA_toptarget_output$top_gene
output<-head(output,n=10)
rownames(output)<-NULL
#names(output)
#table
temp<- knitr::kable(output, align="l")
temp<- kableExtra::kable_styling(temp,font_size=8, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white")
temp<-kableExtra::column_spec(temp, column=c(4,5,6,8), color="red")
temp<- kableExtra::scroll_box(temp, width = "100%", height = "200px")

temp


## ---- eval= FALSE-------------------------------------------------------------
#  #Example of the analysis
#  ENST_input<-c('ENST00000436290', 'ENST00000432892', 'ENST00000454526',
#  'ENST00000423793', 'ENST00000436960','ENST00000412754'
#  )
#  
#  ENST_targets<-c('ENST00000491143', 'ENST00000314191',
#  'ENST00000309733', 'ENST00000377122', 'ENST00000338981',
#  'ENST00000495827', 'ENST00000425708', 'ENST00000272748',
#  ...)
#  nr_top_genes=500
#  analyze_onlyDEtargets=FALSE
#  output<- lnc_RNARNA_scanner(ENST_input, analyze_onlyDEtargets,
#  ENST_targets ,nr_top_genes)
#  names(output)
#  
#  

## ----lnc_RNARNA_scanner: analyze_onlyDEtargets_TRUE, echo=FALSE---------------
utils::data(lnc_RNARNA_scanner_output, package = 'wizbionet')
output<-lnc_RNARNA_scanner_output$lncRNA_DEtargets
output<-head(output,n=10)
rownames(output)<-NULL
#names(output)
#table
temp<- knitr::kable(output, align="l")
temp<- kableExtra::kable_styling(temp,font_size=8, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white")
temp<-kableExtra::column_spec(temp, column=c(10), color="red")
temp<- kableExtra::scroll_box(temp, width = "100%", height = "200px")

temp


## ----lnc_RNARNA_scanner: analyze_onlyDEtargets_FALSE, echo=FALSE--------------
utils::data(lnc_RNARNA_scanner_output, package = 'wizbionet')
output<-lnc_RNARNA_scanner_output$lncRNA_AllTargets
output<-head(output,n=10)
rownames(output)<-NULL
#names(output)
#table
temp<- knitr::kable(output, align="l")
temp<- kableExtra::kable_styling(temp,font_size=8, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white")
temp<-kableExtra::column_spec(temp, column=c(10), color="red")
temp<- kableExtra::scroll_box(temp, width = "100%", height = "200px")

temp


## ----lnc_RNARNA_scanner: result_lnc_RNAtoRNA_list, echo=FALSE-----------------
utils::data(lnc_RNARNA_scanner_output, package = 'wizbionet')
output<-lnc_RNARNA_scanner_output$result_lnc_RNAtoRNA_list$ENST00000436290_minEnergy
output<-head(output,n=10)
rownames(output)<-NULL
#names(output)
#table
temp<- knitr::kable(output, align="l")
temp<- kableExtra::kable_styling(temp,font_size=8, bootstrap_options = c('condensed'), latex_options=c('scale_down'),full_width = FALSE, position = "left", stripe_color = "white")
temp<-kableExtra::column_spec(temp, column=c(4,5))
temp<- kableExtra::scroll_box(temp, width = "100%", height = "200px")

temp


## ----eval=FALSE---------------------------------------------------------------
#  genes<-c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC')
#  counts<- c(66, 62, 54, 40, 34, 32, 32, 16, 15, 15, 15, 14,10)
#  input<- data.frame(genes,counts)
#  
#  wizbionet::venny.list(input$genes)
#  

