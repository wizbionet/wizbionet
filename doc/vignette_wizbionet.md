---
title: "vignette-wizbionet"
author: "Zofia Wicik"
date: "2020-09-02"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{vignette-wizbionet}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---
<!-- .markdown-block { -->
<!-- 	padding-top: 0 !important; -->
<!-- 	padding-bottom: 0 !important; -->
<!-- } -->


## Introduction
This package was build to provide set of tools enabling identification of the top genes and non-coding RNAs (miRNAs, lncRNAs) from expression studies. It can also be applied to arbitrary selected lists of genes mined from the literature. 

In order to identify  best coding and non-coding genes that would serve as key regulators of complex diseases, we developed a key-gene scoring system taking into account their mutual regulation. In this document we we will try to  show examples of analyses which can be made with this toolbox:

## Installation

```r
#Some of the dependencies are not downloaded automatically yet. 
#Below is the code which will install all of them. Just copy it and paste to your R console
#dependencies
#dplyr (>= 1.0.2), multiMiR (>= 1.8.0),  stringr (>= 1.4.0),  XML (>= 3.99-0.5), 
#OneR (>= 2.2.0), plyr (>= 1.8.6), 
#tidyselect (>= 1.1.0), kableExtra (>= 1.1.0), knitr (>= 1.29), rmarkdown (>= 2.3), utils 


# 1. installation of the necessary packages, if it will not work download source file from the webpage.
    #https://www.bioconductor.org/packages/release/bioc/html/multiMiR.html
  
      if (!requireNamespace("BiocManager", quietly=TRUE))
          install.packages("BiocManager")
      BiocManager::install()
      BiocManager::install("multiMiR")
    
    # https://cran.r-project.org/web/packages/OneR/index.html
    install.packages("OneR", type = "binary") 
    
    #https://cran.r-project.org/web/packages/kableExtra/
    install.packages('kableExtra',  type = "binary")
    

# 2 A. You can  install package wizbionet from the GitHub use this command:
    install.packages("remotes")
    remotes::install_github("wizbionet/wizbionet", dependencies ="Depends")
    
# 2 B.Or install wizbionet from the wizbionet_0.99.0.tar.gz file downloaded from this link:
    #https://github.com/wizbionet/wizbionet/raw/master/wizbionet_0.99.0.tar.gz
    
    install.packages("https://github.com/wizbionet/wizbionet/raw/master/wizbionet_0.99.0.tar.gz", 
                 repos = NULL, type = "source", 
                 dependencies =TRUE
                 )

#Voila, load the package:
library(wizbionet)
```


## wizbionet workflow example


### 1. importing gene lists to the R

This set of functions enables combining gene lists associated with your process of interest. You can copy columns from excel and paste them to R using command:


```r
# genelistGWAS<- readClipboard()
# genelistGO<- readClipboard()
# genelistKEGG<- readClipboard()
```



### 2. Updating gene symbols annotation using NCBI_synonyms()

The common problem while working with different gene lists are not matching gene symbols which can generates duplicates while merging them. this package offers tool for efficient annotation of human genes according to NCBI nomenclature using function **NCBI_synonyms()**. Notice that gene EP3 has now symbol PTGER3, and SNT3 has symbol SNTB2.


```r
genelistGWAS<- as.data.frame(genelistGWAS)
NCBI_synonyms(genelistGWAS, "genelistGWAS")
```
<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> genelistGWAS </th>
   <th style="text-align:left;"> SymbolNCBI </th>
   <th style="text-align:left;"> EntrezID </th>
   <th style="text-align:left;"> ENSG_ID </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;color: red !important;"> SGCD </td>
   <td style="text-align:left;"> 6444 </td>
   <td style="text-align:left;"> ENSG00000170624 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;color: red !important;"> TBC1D8B </td>
   <td style="text-align:left;"> 54885 </td>
   <td style="text-align:left;"> ENSG00000133138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> EP3 </td>
   <td style="text-align:left;color: red !important;"> PTGER3 </td>
   <td style="text-align:left;"> 5733 </td>
   <td style="text-align:left;"> ENSG00000050628 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;color: red !important;"> ANO5 </td>
   <td style="text-align:left;"> 203859 </td>
   <td style="text-align:left;"> ENSG00000171714 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;color: red !important;"> FGFR1 </td>
   <td style="text-align:left;"> 2260 </td>
   <td style="text-align:left;"> ENSG00000077782 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;color: red !important;"> PTGFR </td>
   <td style="text-align:left;"> 5737 </td>
   <td style="text-align:left;"> ENSG00000122420 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SNT3 </td>
   <td style="text-align:left;color: red !important;"> SNTB2 </td>
   <td style="text-align:left;"> 6645 </td>
   <td style="text-align:left;"> ENSG00000168807 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;color: red !important;"> USP9Y </td>
   <td style="text-align:left;"> 8287 </td>
   <td style="text-align:left;"> ENSG00000114374 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;color: red !important;"> PTPRM </td>
   <td style="text-align:left;"> 5797 </td>
   <td style="text-align:left;"> ENSG00000173482 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;color: red !important;"> CRIM1 </td>
   <td style="text-align:left;"> 51232 </td>
   <td style="text-align:left;"> ENSG00000150938 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;color: red !important;"> BRD1 </td>
   <td style="text-align:left;"> 23774 </td>
   <td style="text-align:left;"> ENSG00000100425 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;color: red !important;"> RAD23B </td>
   <td style="text-align:left;"> 5887 </td>
   <td style="text-align:left;"> ENSG00000119318 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;color: red !important;"> PRKDC </td>
   <td style="text-align:left;"> 5591 </td>
   <td style="text-align:left;"> ENSG00000253729 </td>
  </tr>
</tbody>
</table>

### 3. Selecting columns based on syntax using col_selector()

If you are not interested in other columns except for the official gene symbols you can use syntax specific function:


```r
col_selector(genelistGWAS, key_words = "SymbolNCBI")
#Use Regular Expression Syntax (https://rstudio.com/wp-content/uploads/2016/09/RegExCheatsheet.pdf) to precisely select columns:
#Meta characters . * + 
#Anchors: ^ Start of the string; $ End of the string 
```


### 4. Binding multiple gene lists and/or  data.frames of unequal lenght using cbind_filler()

To be able to bind multiple gene lists and/or  data.frames of unequal lenght u can use **cbind_filler()**

```r
output<- cbind_filler(list(genelistGWAS,genelistGO,genelistKEEG))
```
If you are working with vectors after binding them you will need to add names manually. If the gene lists were data frames with headings you don't need to do this.

```r
names(output)<-c('genelistGWAS','genelistGO','genelistKEEG')
```


Below is example data frame merged using **cbind_filler()** function with suggestions of the sources of gene lists. The advantage of this function is that it allows to combine vectors/data frames of different lenght

```r
output<- cbind_filler(output)
```

<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> genelistGWAS </th>
   <th style="text-align:left;"> genelistGO </th>
   <th style="text-align:left;"> genelistKEGG </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:left;"> SGCD </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> TBC1D8B </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> NEBL </td>
   <td style="text-align:left;"> PTGER3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;"> KAT6A </td>
   <td style="text-align:left;"> ANO5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> FGFR1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> PTGFR </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SNTB2 </td>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;"> NELL1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> NR2C2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> TGFB3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> BRD1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> RAD23B </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> PRKDC </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> IGSF10 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> AKIRIN1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> HACD4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> C4orf32 </td>
  </tr>
</tbody>
</table>

### 5. Combining and summarizing multiple gene lists using lists.combiner()
When you have already a data frame build using **cbind_filler()** or just imported form txt/excel or csv file, we suggest to use function **lists.combiner()**. 
This function will merge all of those data frames and will provide information in which list a given gene was present and in how many lists in total it appeared. 
 

```r
output<- lists.combiner(output)
head(output, n=15)
```

<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> input </th>
   <th style="text-align:left;"> genelistGWAS </th>
   <th style="text-align:left;"> genelistGO </th>
   <th style="text-align:left;"> genelistKEGG </th>
   <th style="text-align:right;"> count </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SNTB2 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;color: red !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;color: red !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;color: red !important;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;color: red !important;"> 1 </td>
  </tr>
</tbody>
</table>

Now you have a complete list of genes of interest (column input) and can easily see that gene PTGER3 was present in all of those data sets. You can also use function **NCBI_synonyms()** to add gene IDs.  

```r
output<- NCBI_synonyms(output, "input")
head(output, n=10)
```



<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> input </th>
   <th style="text-align:left;"> genelistGWAS </th>
   <th style="text-align:left;"> genelistGO </th>
   <th style="text-align:left;"> genelistKEGG </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:left;"> SymbolNCBI </th>
   <th style="text-align:left;"> EntrezID </th>
   <th style="text-align:left;"> ENSG_ID </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;color: red !important;"> PTGER3 </td>
   <td style="text-align:left;color: red !important;"> 5733 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000050628 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;color: red !important;"> BRD1 </td>
   <td style="text-align:left;color: red !important;"> 23774 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000100425 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;color: red !important;"> RAD23B </td>
   <td style="text-align:left;color: red !important;"> 5887 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000119318 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;color: red !important;"> PRKDC </td>
   <td style="text-align:left;color: red !important;"> 5591 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000253729 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;color: red !important;"> SGCD </td>
   <td style="text-align:left;color: red !important;"> 6444 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000170624 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;color: red !important;"> TBC1D8B </td>
   <td style="text-align:left;color: red !important;"> 54885 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000133138 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;color: red !important;"> ANO5 </td>
   <td style="text-align:left;color: red !important;"> 203859 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000171714 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;color: red !important;"> FGFR1 </td>
   <td style="text-align:left;color: red !important;"> 2260 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000077782 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;color: red !important;"> PTGFR </td>
   <td style="text-align:left;color: red !important;"> 5737 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000122420 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;color: red !important;"> PTPRM </td>
   <td style="text-align:left;color: red !important;"> 5797 </td>
   <td style="text-align:left;color: red !important;"> ENSG00000173482 </td>
  </tr>
</tbody>
</table>

### 6. Clusterization of gene lists using clusterizer_oneR()


If you want to know genes associated with highest number of genes lists you can use function **clusterizer_oneR()**, which will divide genes from the "input" column into four clusters based on column "count". clusterizer_oneR() utilzes Jenks natural breaks optimization algorithm from the original OneR package as a non-arbitrary classification dividing numbers of regulated genes into four categories (clusters). advantage of this method is non-arbitrary selection of top hits. You can cluster multiple numeric columns using this function. If you want to change the number of bins or method of the clusterization you can use function OneR::bin

```r
landmark_col,="SymbolNCBI"
cols_to_cluster="count"
output<- clusterizer_oneR(output, landmark_col, cols_to_cluster) 
head(output, n=10)
```


<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> input </th>
   <th style="text-align:left;"> genelistGWAS </th>
   <th style="text-align:left;"> genelistGO </th>
   <th style="text-align:left;"> genelistKEGG </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:left;"> SymbolNCBI </th>
   <th style="text-align:left;"> EntrezID </th>
   <th style="text-align:left;"> ENSG_ID </th>
   <th style="text-align:left;"> clus_count </th>
   <th style="text-align:left;"> clusNR_count </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> 5733 </td>
   <td style="text-align:left;"> ENSG00000050628 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> 23774 </td>
   <td style="text-align:left;"> ENSG00000100425 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> 5887 </td>
   <td style="text-align:left;"> ENSG00000119318 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> 5591 </td>
   <td style="text-align:left;"> ENSG00000253729 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;"> 6444 </td>
   <td style="text-align:left;"> ENSG00000170624 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;"> 54885 </td>
   <td style="text-align:left;"> ENSG00000133138 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;"> 203859 </td>
   <td style="text-align:left;"> ENSG00000171714 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> 2260 </td>
   <td style="text-align:left;"> ENSG00000077782 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;"> 5737 </td>
   <td style="text-align:left;"> ENSG00000122420 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> 5797 </td>
   <td style="text-align:left;"> ENSG00000173482 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;"> 51232 </td>
   <td style="text-align:left;"> ENSG00000150938 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SNTB2 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> SNTB2 </td>
   <td style="text-align:left;"> 6645 </td>
   <td style="text-align:left;"> ENSG00000168807 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;color: red !important;"> cl3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;"> 8287 </td>
   <td style="text-align:left;"> ENSG00000114374 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;color: red !important;"> cl3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:left;"> 64403 </td>
   <td style="text-align:left;"> ENSG00000139880 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;color: red !important;"> cl3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> 9480 </td>
   <td style="text-align:left;"> ENSG00000119547 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;color: red !important;"> cl3 </td>
  </tr>
</tbody>
</table>

### 7. Clusterization of gene lists using top_percent()


top_percent() is an alternative for **clusterizer_oneR()** which doesn't deal well with continuous numbers like p-values or fold changes. This function enables comparison of data sets of different length.
It is suggested to use it on gene lists which have associated numeric values.
Prioritization of the analyzed gene lists can  be based on the scores assigned after data aggregation and counting.
This function helps to avoid arbitrary selection of top candidates, selecting top percent of genes for a given cutoff. It includes all genes close to a cutoff if they have same value. It generates new column with TRUE or FALSE value giving information if our gene was present in the top percents.


```r
landmark_col,="SymbolNCBI"
cols_to_cluster="count"
cutoff=25
output<- clusterizer_oneR(output, landmark_col, cols_to_cluster, cutoff) 
head(output, n=10)
```


<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> input </th>
   <th style="text-align:left;"> genelistGWAS </th>
   <th style="text-align:left;"> genelistGO </th>
   <th style="text-align:left;"> genelistKEGG </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:left;"> SymbolNCBI </th>
   <th style="text-align:left;"> EntrezID </th>
   <th style="text-align:left;"> ENSG_ID </th>
   <th style="text-align:left;"> clus25p_count </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> 5733 </td>
   <td style="text-align:left;"> ENSG00000050628 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:left;"> 23774 </td>
   <td style="text-align:left;"> ENSG00000100425 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:left;"> 5887 </td>
   <td style="text-align:left;"> ENSG00000119318 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> 5591 </td>
   <td style="text-align:left;"> ENSG00000253729 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:left;"> 6444 </td>
   <td style="text-align:left;"> ENSG00000170624 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:left;"> 54885 </td>
   <td style="text-align:left;"> ENSG00000133138 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:left;"> 203859 </td>
   <td style="text-align:left;"> ENSG00000171714 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> 2260 </td>
   <td style="text-align:left;"> ENSG00000077782 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:left;"> 5737 </td>
   <td style="text-align:left;"> ENSG00000122420 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:left;"> 5797 </td>
   <td style="text-align:left;"> ENSG00000173482 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:left;"> 51232 </td>
   <td style="text-align:left;"> ENSG00000150938 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SNTB2 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> SNTB2 </td>
   <td style="text-align:left;"> 6645 </td>
   <td style="text-align:left;"> ENSG00000168807 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;"> 8287 </td>
   <td style="text-align:left;"> ENSG00000114374 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:left;"> 64403 </td>
   <td style="text-align:left;"> ENSG00000139880 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> 9480 </td>
   <td style="text-align:left;"> ENSG00000119547 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
</tbody>
</table>


### 8. Merging of the multiple data frames with headings preservation using dataframe.merger() 
As you can see in the output appeared two columns 'clus_count' and	'clusNR_count'. First column provides logical information if gene was present in the top two clusters (cl1, cl2). Second column provides information in which cluster appeared this gene. 
You can combine this data frame with your another data frame prioritized in same way using common column (in this case "SymbolNCBI")  and function **dataframe.merger()**.

```r
dataframe_list=list('output'=output, 'other_dataframe'=other_dataframe)
ID_column="input"
dataframe.merger(dataframe_list,  ID_column="input")
```
If you are analyzing two data sets using this approach you can select genes present in both of them, so called top genes. This approach enables quick selection of top candidates across multiple datasates. 


```r
landmark_col="SymbolNCBI" 
cols_to_cluster= c("count", 'count_regulatory_miRNA')
output<- clusterizer_oneR(output, landmark_col, cols_to_cluster) 
head(output, n=10)
```

<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> SymbolNCBI </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:right;"> count_regulatory_miRNA </th>
   <th style="text-align:left;"> clus_count </th>
   <th style="text-align:left;"> clusNR_count </th>
   <th style="text-align:left;"> clus_count_regulatory_miRNA </th>
   <th style="text-align:left;"> clusNR_count_regulatory_miRNA </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> -3 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> BRD1 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 79 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 45 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 89 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 6 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO5 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 62 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 87 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTGFR </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 48 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> PTPRM </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 92 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 37 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SNTB2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 98 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 88 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 26 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:right;"> 1 </td>
   <td style="text-align:right;"> 102 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
</tbody>
</table>

### 9. Aggregation and summarizing of the rows across multiple columns using col_agrecounter()

Function ***col_agrecounter*()*** allows to aggregates and summarize complex data frames with preserving names of the columns and providing:
- aggregated occurrences for example genes or miRNAs in a column with preserved name and suffix "_coll"
- count of occurrences from column "_coll" as collumn with suffix "_count". After this function we suggest runing top_percent() or clusterizer_oneR() to see which miRNAs are the most interesting ones based on the number of regulated targets. 


```r
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
    
    rows_collapse <-col_to_string(inputDF$pre_miRNA)
#additional landmark column which will not allow to deduplicate. useful when you want to analyze pre-miRNAs instead of mature mirNAs
    control_col<- "mature_miRNA"

#run function    
output<- col_agrecounter(inputDF, col_names, col_collapse , rows_collapse, control_col)
```


```
#> [1] "inputDF- dataframe for aggegation and counting (A&C)"
#> [1] "col_names- column names which will be A&C"
#> [1] "col_collapse- landmark column for A&C columns"
#> [1] "rows_collapse- content of the column  landmark column all_of(col_collapse) as vector "
#> [1] "control_col- additional landmark column"
#> [1] "hsa-miR-195 count: 4 Target"
#> [1] "hsa-miR-4753 count: 2 Target"
```

<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;">   </th>
   <th style="text-align:left;"> mature_miRNA </th>
   <th style="text-align:left;"> pre_miRNA </th>
   <th style="text-align:left;"> Target </th>
   <th style="text-align:left;"> control </th>
   <th style="text-align:left;"> Target_coll </th>
   <th style="text-align:right;"> Target_COUNT </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> hsa-miR-195-3p </td>
   <td style="text-align:left;"> hsa-miR-195 </td>
   <td style="text-align:left;"> PAX1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> CDH24|ONECUT2|PAX1|PTGER3 </td>
   <td style="text-align:right;color: red !important;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> hsa-miR-195-5p </td>
   <td style="text-align:left;"> hsa-miR-195 </td>
   <td style="text-align:left;"> CDH24 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> CDH24|ONECUT2|PAX1|PTGER3 </td>
   <td style="text-align:right;color: red !important;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> hsa-miR-195-5p </td>
   <td style="text-align:left;"> hsa-miR-195 </td>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> CDH24|ONECUT2|PAX1|PTGER3 </td>
   <td style="text-align:right;color: red !important;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> hsa-miR-195-5p </td>
   <td style="text-align:left;"> hsa-miR-195 </td>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> CDH24|ONECUT2|PAX1|PTGER3 </td>
   <td style="text-align:right;color: red !important;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> hsa-miR-4753-3p </td>
   <td style="text-align:left;"> hsa-miR-4753 </td>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> FGFR1|TGFB3 </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> hsa-miR-4753-5p </td>
   <td style="text-align:left;"> hsa-miR-4753 </td>
   <td style="text-align:left;"> TGFB3 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> FGFR1|TGFB3 </td>
   <td style="text-align:right;color: red !important;"> 2 </td>
  </tr>
</tbody>
</table>

### 10. Identification of the top genes across datasets

Using base::subset function you can extract top genes which got high scores in both columns in this case "count" and  'count_regulatory_miRNA'. 






```r
output<-subset(output, output$clus_count==TRUE & output$clus_count_regulatory_miRNA==TRUE ) 
```
Example data frame:
<table class="table table-condensed" style="font-size: 9px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;"> SymbolNCBI </th>
   <th style="text-align:right;"> count </th>
   <th style="text-align:right;"> count_regulatory_miRNA </th>
   <th style="text-align:left;"> clus_count </th>
   <th style="text-align:left;"> clusNR_count </th>
   <th style="text-align:left;"> clus_count_regulatory_miRNA </th>
   <th style="text-align:left;"> clusNR_count_regulatory_miRNA </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> PTGER3 </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 90 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> RAD23B </td>
   <td style="text-align:right;"> 3 </td>
   <td style="text-align:right;"> 111 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SGCD </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 61 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TBC1D8B </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 86 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> FGFR1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 70 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CRIM1 </td>
   <td style="text-align:right;"> 2 </td>
   <td style="text-align:right;"> 115 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
  </tr>
</tbody>
</table>



### 11. Identification of the top miRNAs and top targets using topmiRNA_toptarget()### 

As top miRNAs we define miRNAs associated with your process of interest and regulating highest number of deferentially expressed genes (DE genes). If you have expression data for miRNAs and mRNAs you can perform target predictions to identify pairs of oppositely regulated miRNAs and genes use function **topmiRNA_toptarget()**. This function retrieves miRNA-target interactions and identify miRNAs and genes with highest number of analyzed interactions with miRNAs. You can also use only targets associated with a specific process to identify top miRNAs regulating it. 


```r
#generate and modify list of arguments. Important: Don't add mirna=  and  target= fields they are already included as DEmir_up,DEgenes_down,DEmir_down, DEgenes_up!
multimir_args<- as.list(args(multiMiR::get_multimir)) 

#add lists of DE miRNAs and genes
DEmir_up<-c('hsa-miR-150-5p','hsa-miR-448-5p','hsa-miR-448-3p',
            'hsa-miR-493-5p','hsa-miR-493-3p') # example DE miRNAs
DEgenes_down<-c('5797','8826','7994','2775','7182','79647','5733',
                '158158','9480','8626','50636') # example DE genes
DEmir_down<-c('hsa-miR-4731-5p','hsa-miR-541-3p','hsa-miR-449b-5p','hsa-miR-541-5p')
DEgenes_up<-c('203859','4745','4916','126298','2258','8464','55917','23450','29767')
mirna_type<-"pre_mir" # "mature_mir"
multimir_args= list(url = NULL,
                    org = "hsa",
                    table = "all",
                    predicted.cutoff = 10,
                    predicted.cutoff.type = "p",
                    predicted.site = "conserved"
)

#execute function
output<- topmiRNA_toptarget(DEmir_up,DEgenes_down,                                       DEmir_down, DEgenes_up, multimir_args,mirna_type)


#execute function
output<-wizbionet::topmiRNA_toptarget(DEmir_up,DEgenes_down,DEmir_down, 
                                      DEgenes_up, mir_type, multimir_args)
output$multimir_output
output$top_miR
output$top_gene
```


#### Output of the **topmiRNA_toptarget()** is a list() with three data frames named: 


##### **A. multimir_output**

Data frame *multimir_output* is based on original output from the multiMiR::get_multimir(), but integrates two separate analyses for up and down regulated miRNAs. Directionality of expression is shown in the column "multimir". Additionally, at the end of the dataframe is added column "premir" where are present names of analyzed miRNAs before maturation.   


<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:200px; overflow-x: scroll; width:100%; "><table class="table table-condensed" style="font-size: 8px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> database </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> mature_mirna_acc </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> mature_mirna_id </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_symbol </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_entrez </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_ensembl </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> experiment </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> support_type </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> pubmed_id </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> type </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> score </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> disease_drug </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> paper_pubmedID </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> multimir </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> premir </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> mirtarbase </td>
   <td style="text-align:left;"> MIMAT0000451 </td>
   <td style="text-align:left;"> hsa-miR-150-5p </td>
   <td style="text-align:left;"> ANO7 </td>
   <td style="text-align:left;"> 50636 </td>
   <td style="text-align:left;"> ENSG00000146205 </td>
   <td style="text-align:left;"> HITS-CLIP </td>
   <td style="text-align:left;"> Functional MTI (Weak) </td>
   <td style="text-align:left;"> 23824327 </td>
   <td style="text-align:left;"> validated </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> mirtarbase </td>
   <td style="text-align:left;"> MIMAT0000451 </td>
   <td style="text-align:left;"> hsa-miR-150-5p </td>
   <td style="text-align:left;"> AKIRIN1 </td>
   <td style="text-align:left;"> 79647 </td>
   <td style="text-align:left;"> ENSG00000174574 </td>
   <td style="text-align:left;"> HITS-CLIP </td>
   <td style="text-align:left;"> Functional MTI (Weak) </td>
   <td style="text-align:left;"> 23824327 </td>
   <td style="text-align:left;"> validated </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tarbase </td>
   <td style="text-align:left;"> MIMAT0000451 </td>
   <td style="text-align:left;"> hsa-miR-150-5p </td>
   <td style="text-align:left;"> IQGAP1 </td>
   <td style="text-align:left;"> 8826 </td>
   <td style="text-align:left;"> ENSG00000140575 </td>
   <td style="text-align:left;"> Degradome sequencing </td>
   <td style="text-align:left;"> positive </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> validated </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> tarbase </td>
   <td style="text-align:left;"> MIMAT0003161 </td>
   <td style="text-align:left;"> hsa-miR-493-3p </td>
   <td style="text-align:left;"> IQGAP1 </td>
   <td style="text-align:left;"> 8826 </td>
   <td style="text-align:left;"> ENSG00000140575 </td>
   <td style="text-align:left;"> Degradome sequencing </td>
   <td style="text-align:left;"> positive </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> validated </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> diana_microt </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> KAT6A </td>
   <td style="text-align:left;"> 7994 </td>
   <td style="text-align:left;"> ENSG00000083168 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 0.998 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> diana_microt </td>
   <td style="text-align:left;"> MIMAT0000451 </td>
   <td style="text-align:left;"> hsa-miR-150-5p </td>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> 9480 </td>
   <td style="text-align:left;"> ENSG00000119547 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 0.936 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> diana_microt </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> TP63 </td>
   <td style="text-align:left;"> 8626 </td>
   <td style="text-align:left;"> ENSG00000073282 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 0.88 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> elmmo </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> KAT6A </td>
   <td style="text-align:left;"> 7994 </td>
   <td style="text-align:left;"> ENSG00000083168 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 0.881 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> elmmo </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> 9480 </td>
   <td style="text-align:left;"> ENSG00000119547 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 0.742 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> elmmo </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> NR2C2 </td>
   <td style="text-align:left;"> 7182 </td>
   <td style="text-align:left;"> ENSG00000177463 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 0.598 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> elmmo </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> TP63 </td>
   <td style="text-align:left;"> 8626 </td>
   <td style="text-align:left;"> ENSG00000073282 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 0.532 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> microcosm </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> NR2C2 </td>
   <td style="text-align:left;"> 7182 </td>
   <td style="text-align:left;"> ENSG00000177463 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 18.3062 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> microcosm </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> ANO7 </td>
   <td style="text-align:left;"> 50636 </td>
   <td style="text-align:left;"> ENSG00000146205 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 17.8267 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pictar </td>
   <td style="text-align:left;"> MIMAT0002813 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> KAT6A </td>
   <td style="text-align:left;"> 7994 </td>
   <td style="text-align:left;"> ENSG00000083168 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> 29.652 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-493 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> pita </td>
   <td style="text-align:left;"> MIMAT0000451 </td>
   <td style="text-align:left;"> hsa-miR-150-5p </td>
   <td style="text-align:left;"> KAT6A </td>
   <td style="text-align:left;"> 7994 </td>
   <td style="text-align:left;"> ENSG00000083168 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> predicted </td>
   <td style="text-align:left;"> -10.53 </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;"> NA </td>
   <td style="text-align:left;color: red !important;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150 </td>
  </tr>
</tbody>
</table></div>



##### **B. top_miR**

Data frame *top_miR* has aggregated and prioritized results from get_multimir output showing number of genes associated with pre-miRNAs. It has columns with name *clus_...* providing logical information if gene was in top 2 clusters (cl1 and cl2) ~top 20 percents and column *clusNR_..*. providing information in which cluster the gene was present (cl1,cl2,cl3,cl4). It enables quick identification of the miRNAs regulating highest number of analyzed targets

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:200px; overflow-x: scroll; width:100%; "><table class="table table-condensed" style="font-size: 8px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> premir </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> mature_mirna_id </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> mature_mirna_id_coll </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> mature_mirna_id_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> multimir_coll </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> mature_mirna_acc </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_symbol_coll </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_symbol_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> type_coll </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> type_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> clus_target_symbol_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> clusNR_target_symbol_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> clus25p_target_symbol_COUNT </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> hsa-miR-493 </td>
   <td style="text-align:left;"> hsa-miR-493-3p </td>
   <td style="text-align:left;"> hsa-miR-493-3p|hsa-miR-493-5p </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> MIMAT0003161 </td>
   <td style="text-align:left;color: red !important;"> ANO7|GNAO1|IQGAP1|KAT6A|NR2C2|ONECUT2|TP63 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> predicted|validated </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hsa-miR-493 </td>
   <td style="text-align:left;"> hsa-miR-493-5p </td>
   <td style="text-align:left;"> hsa-miR-493-3p|hsa-miR-493-5p </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> MIMAT0002813 </td>
   <td style="text-align:left;color: red !important;"> ANO7|GNAO1|IQGAP1|KAT6A|NR2C2|ONECUT2|TP63 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> predicted|validated </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hsa-miR-449b </td>
   <td style="text-align:left;"> hsa-miR-449b-5p </td>
   <td style="text-align:left;"> hsa-miR-449b-5p </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> data_DEmir_down_DEgenes_up </td>
   <td style="text-align:left;color: red !important;"> MIMAT0003327 </td>
   <td style="text-align:left;color: red !important;"> CTTNBP2NL|IRGQ|NTRK3|SF3B3|SUPT3H </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> predicted|validated </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hsa-miR-150 </td>
   <td style="text-align:left;"> hsa-miR-150-5p </td>
   <td style="text-align:left;"> hsa-miR-150-5p </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> data_DEmir_up_DEgenes_down </td>
   <td style="text-align:left;color: red !important;"> MIMAT0000451 </td>
   <td style="text-align:left;color: red !important;"> AKIRIN1|ANO7|IQGAP1|KAT6A|ONECUT2 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> predicted|validated </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> TRUE </td>
   <td style="text-align:left;color: red !important;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hsa-miR-541 </td>
   <td style="text-align:left;"> hsa-miR-541-3p </td>
   <td style="text-align:left;"> hsa-miR-541-3p|hsa-miR-541-5p </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> data_DEmir_down_DEgenes_up </td>
   <td style="text-align:left;color: red !important;"> MIMAT0004920 </td>
   <td style="text-align:left;color: red !important;"> NTRK3|SF3B3|TMOD2 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> predicted|validated </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;color: red !important;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hsa-miR-541 </td>
   <td style="text-align:left;"> hsa-miR-541-5p </td>
   <td style="text-align:left;"> hsa-miR-541-3p|hsa-miR-541-5p </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> data_DEmir_down_DEgenes_up </td>
   <td style="text-align:left;color: red !important;"> MIMAT0004919 </td>
   <td style="text-align:left;color: red !important;"> NTRK3|SF3B3|TMOD2 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> predicted|validated </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;color: red !important;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hsa-miR-4731 </td>
   <td style="text-align:left;"> hsa-miR-4731-5p </td>
   <td style="text-align:left;"> hsa-miR-4731-5p </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> data_DEmir_down_DEgenes_up </td>
   <td style="text-align:left;color: red !important;"> MIMAT0019853 </td>
   <td style="text-align:left;color: red !important;"> IRGQ|SF3B3 </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> predicted|validated </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> FALSE </td>
   <td style="text-align:left;color: red !important;"> cl4 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
</tbody>
</table></div>


##### **C. top_gene**

Data frame *top_gene* has aggregated and prioritized results from get_multimir function showing number of genes associated with analyzed targets. It also has columns with information if gene is in top 20%.


<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:200px; overflow-x: scroll; width:100%; "><table class="table table-condensed" style="font-size: 8px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_symbol </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_entrez </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_ensembl_coll </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> premir_coll </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> premir_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> clus_premir_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> clusNR_premir_COUNT </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> clus25p_premir_COUNT </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> SF3B3 </td>
   <td style="text-align:left;"> 23450 </td>
   <td style="text-align:left;"> ENSG00000189091 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-449b|hsa-miR-4731|hsa-miR-541 </td>
   <td style="text-align:left;color: red !important;"> 3 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl1 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> IRGQ </td>
   <td style="text-align:left;"> 126298 </td>
   <td style="text-align:left;"> ENSG00000167378 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-449b|hsa-miR-4731 </td>
   <td style="text-align:left;color: red !important;"> 2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> NTRK3 </td>
   <td style="text-align:left;"> 4916 </td>
   <td style="text-align:left;"> ENSG00000140538 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-449b|hsa-miR-541 </td>
   <td style="text-align:left;color: red !important;"> 2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ANO7 </td>
   <td style="text-align:left;"> 50636 </td>
   <td style="text-align:left;"> ENSG00000146205 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150|hsa-miR-493 </td>
   <td style="text-align:left;color: red !important;"> 2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> IQGAP1 </td>
   <td style="text-align:left;"> 8826 </td>
   <td style="text-align:left;"> ENSG00000140575 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150|hsa-miR-493 </td>
   <td style="text-align:left;color: red !important;"> 2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> KAT6A </td>
   <td style="text-align:left;"> 7994 </td>
   <td style="text-align:left;"> ENSG00000083168 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150|hsa-miR-493 </td>
   <td style="text-align:left;color: red !important;"> 2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> 9480 </td>
   <td style="text-align:left;"> ENSG00000119547 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-150|hsa-miR-493 </td>
   <td style="text-align:left;color: red !important;"> 2 </td>
   <td style="text-align:left;color: red !important;"> TRUE </td>
   <td style="text-align:left;"> cl2 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> TMOD2 </td>
   <td style="text-align:left;"> 29767 </td>
   <td style="text-align:left;"> ENSG00000128872 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-541 </td>
   <td style="text-align:left;color: red !important;"> 1 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> SUPT3H </td>
   <td style="text-align:left;"> 8464 </td>
   <td style="text-align:left;"> ENSG00000196284 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-449b </td>
   <td style="text-align:left;color: red !important;"> 1 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
  <tr>
   <td style="text-align:left;"> CTTNBP2NL </td>
   <td style="text-align:left;"> 55917 </td>
   <td style="text-align:left;"> ENSG00000143079 </td>
   <td style="text-align:left;color: red !important;"> hsa-miR-449b </td>
   <td style="text-align:left;color: red !important;"> 1 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
   <td style="text-align:left;"> cl3 </td>
   <td style="text-align:left;color: red !important;"> FALSE </td>
  </tr>
</tbody>
</table></div>
### 12. Identification of the top long-non coding RNAs and their targets using lnc_RNARNA_scanner()


Function ***lnc_RNARNA_scanner*** identify targets of lncRNAs by performing automatized mining of the [link](http://rtools.cbrc.jp/cgi-bin/RNARNA/index.pl) database using ENST transcript IDs (ENST_input) as an input. It enables identification of so-called top lncRNAs associated with your process of interest and regulating highest number of deferentially expressed genes (DE genes)
**ENST_input** is a vector of characters (human ENST transcript numbers). RNARNAdb will show information during the analysis if non coding transcript was present in the database. Careful, it sometimes also recognizes miRNAs.

**analyze_onlyDEtargets** TRUE or FALSE (logical), it says if you want to check all possible lncRNA targets or only DE targets.

**ENST_targets** vector of characters of human ENST numbers of your interest, usually DE mRNAs

**nr_top_genes** is a number number of top targets you want to select from all possible targets of lncRNAs. Default value  for RNARNA database top targets output set by us is 500 if you want to compare it with DE genes. Your ENST_targets will be subtracted from this number.



```r
#Example of the analysis
ENST_input<-c('ENST00000436290', 'ENST00000432892', 'ENST00000454526',
'ENST00000423793', 'ENST00000436960','ENST00000412754'
)

ENST_targets<-c('ENST00000491143', 'ENST00000314191',
'ENST00000309733', 'ENST00000377122', 'ENST00000338981',
'ENST00000495827', 'ENST00000425708', 'ENST00000272748',
...)
nr_top_genes=500
analyze_onlyDEtargets=FALSE
output<- lnc_RNARNA_scanner(ENST_input, analyze_onlyDEtargets,
ENST_targets ,nr_top_genes)
names(output)

```

#### lnc_RNARNA_scanner output

Output of **lnc_RNARNA_scanner** function is a list of data frames. To access the lists use $ sign or[[]].
All outputs have column ""full_id" which describes interacting RNAs with your lncRNAs and provide a full name of the lncRNA for example: "List of RNAs interacting with ENST00000423793(RP11-432J22.2)". You can use this column  for aggregating and summarizing those datasets using **col_agrecounter()** and than **clusterizer_oneR()**
to obtain top lncRNAs or top targets.

##### **A. if analyze_onlyDEtargets= was set as TRUE**

The output will include list *"lncRNA_DEtargets"* which has only top DE targets of analyzed lncRNAs
<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:200px; overflow-x: scroll; width:100%; "><table class="table table-condensed" style="font-size: 8px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Rank </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Ensemble_ID </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Position_hg19 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> MinEnergy </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Binding_site_query </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Binding_site_target </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> location </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> SumEnergy </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> full_id </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_source </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> nc_id </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> ENST00000238682 </td>
   <td style="text-align:left;"> TGFB3 </td>
   <td style="text-align:left;"> chr14:76424546-76447534 </td>
   <td style="text-align:left;"> -39.4 </td>
   <td style="text-align:left;"> 1357-1406 </td>
   <td style="text-align:left;"> 1791-1840 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -579.4 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 259 </td>
   <td style="text-align:left;"> ENST00000265354 </td>
   <td style="text-align:left;"> SRF </td>
   <td style="text-align:left;"> chr6:43139038-43149243 </td>
   <td style="text-align:left;"> -34.4 </td>
   <td style="text-align:left;"> 1357-1418 </td>
   <td style="text-align:left;"> 3068-3129 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -452.8 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 393 </td>
   <td style="text-align:left;"> ENST00000392806 </td>
   <td style="text-align:left;"> TMEM119 </td>
   <td style="text-align:left;"> chr12:108983623-108991900 </td>
   <td style="text-align:left;"> -32.7 </td>
   <td style="text-align:left;"> 1349-1403 </td>
   <td style="text-align:left;"> 764-818 </td>
   <td style="text-align:left;"> CDS </td>
   <td style="text-align:left;"> -366.5 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> ENST00000491143 </td>
   <td style="text-align:left;"> ONECUT2 </td>
   <td style="text-align:left;"> chr18:55102918-55158529 </td>
   <td style="text-align:left;"> -22.4 </td>
   <td style="text-align:left;"> 462-512 </td>
   <td style="text-align:left;"> 11203-11253 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -5288.2 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> sumEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 249 </td>
   <td style="text-align:left;"> ENST00000314191 </td>
   <td style="text-align:left;"> PRKDC </td>
   <td style="text-align:left;"> chr8:48685670-48872743 </td>
   <td style="text-align:left;"> -23.1 </td>
   <td style="text-align:left;"> 1353-1400 </td>
   <td style="text-align:left;"> 3325-3372 </td>
   <td style="text-align:left;"> CDS </td>
   <td style="text-align:left;"> -3802.0 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> sumEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 271 </td>
   <td style="text-align:left;"> ENST00000495827 </td>
   <td style="text-align:left;"> PTPLAD2 </td>
   <td style="text-align:left;"> chr9:20999515-21031635 </td>
   <td style="text-align:left;"> -23.6 </td>
   <td style="text-align:left;"> 601-649 </td>
   <td style="text-align:left;"> 3505-3553 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -3730.7 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> sumEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 289 </td>
   <td style="text-align:left;"> ENST00000338981 </td>
   <td style="text-align:left;"> USP9Y </td>
   <td style="text-align:left;"> chrY:14813161-14972764 </td>
   <td style="text-align:left;"> -20.8 </td>
   <td style="text-align:left;"> 528-578 </td>
   <td style="text-align:left;"> 6651-6701 </td>
   <td style="text-align:left;"> CDS </td>
   <td style="text-align:left;"> -3680.9 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> sumEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 295 </td>
   <td style="text-align:left;"> ENST00000377122 </td>
   <td style="text-align:left;"> NEBL </td>
   <td style="text-align:left;"> chr10:21068903-21186531 </td>
   <td style="text-align:left;"> -26.3 </td>
   <td style="text-align:left;"> 872-927 </td>
   <td style="text-align:left;"> 1499-1554 </td>
   <td style="text-align:left;"> CDS </td>
   <td style="text-align:left;"> -3638.4 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> sumEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 305 </td>
   <td style="text-align:left;"> ENST00000309733 </td>
   <td style="text-align:left;"> C4orf32 </td>
   <td style="text-align:left;"> chr4:113066554-113116412 </td>
   <td style="text-align:left;"> -19.3 </td>
   <td style="text-align:left;"> 1425-1472 </td>
   <td style="text-align:left;"> 4944-4991 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -3609.7 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> sumEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 428 </td>
   <td style="text-align:left;"> ENST00000282466 </td>
   <td style="text-align:left;"> IGSF10 </td>
   <td style="text-align:left;"> chr3:151151283-151176497 </td>
   <td style="text-align:left;"> -18.8 </td>
   <td style="text-align:left;"> 463-510 </td>
   <td style="text-align:left;"> 7622-7669 </td>
   <td style="text-align:left;"> CDS </td>
   <td style="text-align:left;"> -3339.0 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> sumEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
</tbody>
</table></div>



##### **B. if analyze_onlyDEtargets= was set as FALSE**

The output will include list *"lncRNA_AllTargets"* which has all possible top targets of analyzed lncRNAs
<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:200px; overflow-x: scroll; width:100%; "><table class="table table-condensed" style="font-size: 8px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Rank </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Ensemble_ID </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Position_hg19 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> MinEnergy </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Binding_site_query </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Binding_site_target </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> location </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> SumEnergy </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> full_id </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> target_source </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> nc_id </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> ENST00000607599 </td>
   <td style="text-align:left;"> CHURC1 </td>
   <td style="text-align:left;"> chr14:65381080-65402086 </td>
   <td style="text-align:left;"> -60.6 </td>
   <td style="text-align:left;"> 775-836 </td>
   <td style="text-align:left;"> 1206-1267 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -1678.9 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> ENST00000373833 </td>
   <td style="text-align:left;"> RCC1 </td>
   <td style="text-align:left;"> chr1:28832570-28865812 </td>
   <td style="text-align:left;"> -50.4 </td>
   <td style="text-align:left;"> 1354-1417 </td>
   <td style="text-align:left;"> 2332-2395 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -753.8 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> ENST00000599531 </td>
   <td style="text-align:left;"> PNMAL2 </td>
   <td style="text-align:left;"> chr19:46994449-46999755 </td>
   <td style="text-align:left;"> -49.0 </td>
   <td style="text-align:left;"> 1353-1404 </td>
   <td style="text-align:left;"> 3518-3569 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -807.4 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> ENST00000329047 </td>
   <td style="text-align:left;"> SEPT9 </td>
   <td style="text-align:left;"> chr17:75315598-75496674 </td>
   <td style="text-align:left;"> -46.0 </td>
   <td style="text-align:left;"> 1359-1408 </td>
   <td style="text-align:left;"> 701-750 </td>
   <td style="text-align:left;"> UTR5 </td>
   <td style="text-align:left;"> -762.7 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> ENST00000507938 </td>
   <td style="text-align:left;"> AC090587.2 </td>
   <td style="text-align:left;"> chr11:3837983-3843130 </td>
   <td style="text-align:left;"> -45.3 </td>
   <td style="text-align:left;"> 1369-1416 </td>
   <td style="text-align:left;"> 846-893 </td>
   <td style="text-align:left;"> ncRNA </td>
   <td style="text-align:left;"> -563.6 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> ENST00000382764 </td>
   <td style="text-align:left;"> CYorf17 </td>
   <td style="text-align:left;"> chrY:23544841-23548246 </td>
   <td style="text-align:left;"> -44.9 </td>
   <td style="text-align:left;"> 1370-1419 </td>
   <td style="text-align:left;"> 690-739 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -240.1 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> ENST00000392857 </td>
   <td style="text-align:left;"> ORC4 </td>
   <td style="text-align:left;"> chr2:148687969-148778292 </td>
   <td style="text-align:left;"> -43.9 </td>
   <td style="text-align:left;"> 1359-1417 </td>
   <td style="text-align:left;"> 5893-5951 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -2518.1 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> ENST00000409085 </td>
   <td style="text-align:left;"> AAK1 </td>
   <td style="text-align:left;"> chr2:69694920-69870849 </td>
   <td style="text-align:left;"> -43.9 </td>
   <td style="text-align:left;"> 1357-1414 </td>
   <td style="text-align:left;"> 4140-4197 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -3785.1 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> ENST00000562343 </td>
   <td style="text-align:left;"> RP11-923I11.6 </td>
   <td style="text-align:left;"> chr12:52211684-52213934 </td>
   <td style="text-align:left;"> -43.5 </td>
   <td style="text-align:left;"> 1347-1406 </td>
   <td style="text-align:left;"> 1901-1960 </td>
   <td style="text-align:left;"> ncRNA </td>
   <td style="text-align:left;"> -493.7 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> ENST00000361183 </td>
   <td style="text-align:left;"> CAPZA2 </td>
   <td style="text-align:left;"> chr7:116502528-116562103 </td>
   <td style="text-align:left;"> -43.3 </td>
   <td style="text-align:left;"> 1348-1410 </td>
   <td style="text-align:left;"> 4122-4184 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -1903.7 </td>
   <td style="text-align:left;color: red !important;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
   <td style="text-align:left;"> minEnergy </td>
   <td style="text-align:left;"> ENST00000436290 </td>
  </tr>
</tbody>
</table></div>
##### **C. additionally output always has a list "result_lnc_RNAtoRNA_list"**
This list has complete results (including binding sites, location, rank) for each of the analyzed transcripts.
Each transcript has assigned two sub-lists "ENSTnumber_minEnergy" and "ENSTnumber_sumEnergy"
which were used for selection of the top targets. Those dataframes are a raw otput from RNARNA database.

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:200px; overflow-x: scroll; width:100%; "><table class="table table-condensed" style="font-size: 8px; width: auto !important; ">
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Rank </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Ensemble_ID </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Name </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Position_hg19 </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> MinEnergy </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Binding_site_query </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Binding_site_target </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> location </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> SumEnergy </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> full_id </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> ENST00000607599 </td>
   <td style="text-align:left;"> CHURC1 </td>
   <td style="text-align:left;"> chr14:65381080-65402086 </td>
   <td style="text-align:left;"> -60.6 </td>
   <td style="text-align:left;"> 775-836 </td>
   <td style="text-align:left;"> 1206-1267 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -1678.9 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> ENST00000373833 </td>
   <td style="text-align:left;"> RCC1 </td>
   <td style="text-align:left;"> chr1:28832570-28865812 </td>
   <td style="text-align:left;"> -50.4 </td>
   <td style="text-align:left;"> 1354-1417 </td>
   <td style="text-align:left;"> 2332-2395 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -753.8 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> ENST00000599531 </td>
   <td style="text-align:left;"> PNMAL2 </td>
   <td style="text-align:left;"> chr19:46994449-46999755 </td>
   <td style="text-align:left;"> -49.0 </td>
   <td style="text-align:left;"> 1353-1404 </td>
   <td style="text-align:left;"> 3518-3569 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -807.4 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> ENST00000329047 </td>
   <td style="text-align:left;"> SEPT9 </td>
   <td style="text-align:left;"> chr17:75315598-75496674 </td>
   <td style="text-align:left;"> -46.0 </td>
   <td style="text-align:left;"> 1359-1408 </td>
   <td style="text-align:left;"> 701-750 </td>
   <td style="text-align:left;"> UTR5 </td>
   <td style="text-align:left;"> -762.7 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> ENST00000507938 </td>
   <td style="text-align:left;"> AC090587.2 </td>
   <td style="text-align:left;"> chr11:3837983-3843130 </td>
   <td style="text-align:left;"> -45.3 </td>
   <td style="text-align:left;"> 1369-1416 </td>
   <td style="text-align:left;"> 846-893 </td>
   <td style="text-align:left;"> ncRNA </td>
   <td style="text-align:left;"> -563.6 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 6 </td>
   <td style="text-align:left;"> ENST00000382764 </td>
   <td style="text-align:left;"> CYorf17 </td>
   <td style="text-align:left;"> chrY:23544841-23548246 </td>
   <td style="text-align:left;"> -44.9 </td>
   <td style="text-align:left;"> 1370-1419 </td>
   <td style="text-align:left;"> 690-739 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -240.1 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> ENST00000392857 </td>
   <td style="text-align:left;"> ORC4 </td>
   <td style="text-align:left;"> chr2:148687969-148778292 </td>
   <td style="text-align:left;"> -43.9 </td>
   <td style="text-align:left;"> 1359-1417 </td>
   <td style="text-align:left;"> 5893-5951 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -2518.1 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> ENST00000409085 </td>
   <td style="text-align:left;"> AAK1 </td>
   <td style="text-align:left;"> chr2:69694920-69870849 </td>
   <td style="text-align:left;"> -43.9 </td>
   <td style="text-align:left;"> 1357-1414 </td>
   <td style="text-align:left;"> 4140-4197 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -3785.1 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> ENST00000562343 </td>
   <td style="text-align:left;"> RP11-923I11.6 </td>
   <td style="text-align:left;"> chr12:52211684-52213934 </td>
   <td style="text-align:left;"> -43.5 </td>
   <td style="text-align:left;"> 1347-1406 </td>
   <td style="text-align:left;"> 1901-1960 </td>
   <td style="text-align:left;"> ncRNA </td>
   <td style="text-align:left;"> -493.7 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> ENST00000361183 </td>
   <td style="text-align:left;"> CAPZA2 </td>
   <td style="text-align:left;"> chr7:116502528-116562103 </td>
   <td style="text-align:left;"> -43.3 </td>
   <td style="text-align:left;"> 1348-1410 </td>
   <td style="text-align:left;"> 4122-4184 </td>
   <td style="text-align:left;"> UTR3 </td>
   <td style="text-align:left;"> -1903.7 </td>
   <td style="text-align:left;"> List of RNAs interacting with ENST00000436290(MIR4500HG) </td>
  </tr>
</tbody>
</table></div>


### 13. Copying gene list to the clipboard with venny.list()

If you want to quickly check the overlaps betwen the gene lists you can utilize function venny.list()
it will copy to clipboard the vector of characters, remove NAs and duplicates. Additionally it will print the number of collected items. This function was created to use together with the webpage http://bioinfogp.cnb.csic.es/tools/venny/ or paste results to the excel or cytoscape


```r
genes<-c('SGCD', 'TBC1D8B', 'PTGER3', 'ANO5', 'FGFR1', 'PTGFR','SNTB2', 'USP9Y', 'PTPRM', 'CRIM1', 'BRD1', 'RAD23B', 'PRKDC')
counts<- c(66, 62, 54, 40, 34, 32, 32, 16, 15, 15, 15, 14,10)
input<- data.frame(genes,counts)

wizbionet::venny.list(input$genes)

```


