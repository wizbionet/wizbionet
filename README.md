
<!-- README.md is generated from README.Rmd. Please edit that file -->

# wizbionet

<!-- badges: start -->

<!-- badges: end -->

This package was build to provide set of tools enabling identification
of the top genes and non-coding RNAs (miRNAs, lncRNAs) from expression
studies. It can also be applied to arbitrary selected lists of genes
mined from the literature. In order to identify best coding and
non-coding genes that would serve as key regulators of complex diseases,
we developed a key-gene scoring system taking into account their mutual
regulation.

## Installation

You can install the the development version from tar file available on
<https://github.com/wizbionet/wizbionet>

``` r
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
#Voila, load the package:
library(wizbionet)
```

You can install the the development version from directly from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("wizbionet/wizbionet")
```
"# wizbionet" 
"# wizbionet" 
