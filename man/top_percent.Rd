\name{top_percent}
\alias{top_percent}
\alias{wizbionet::top_percent}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
easy data frame clustering based on percentile
}
\description{
This function enables comparison of data sets of different length.
It is suggested to use it on gene lists which have associated numeric values.
It is an alternative for clusterizer_oneR which doesn't deal well with continuous numbers like p-values or fold changes
Prioritization of the analyzed gene lists can  based on the scores assigned after data aggregation and counting.
This function helps to avoid arbitrary selection of top candidates, subsetting top percent of genes for a given cutoff.
It includes all genes close to a cutoff if they have same value.
It generates new column with TRUE or FALSE value giving information if our gene was present in the top percents.





}
\usage{
top_percent(inputDF,
landmark_col, cols_to_cluster, cutoff)
}
%- maybe also 'usage' for other objects documented here.
\arguments{




  \item{inputDF}{
input data frame, need to have at least two columns landmark_col= and cols_to_cluster=
}



  \item{landmark_col}{
column from the input DF we want to analyze for example column with gene symbols (characters)
}

  \item{cols_to_cluster}{
column or multiple columns from the input DF with numeric scores (counts),
for example number of regulatory miRNAs for each gene, number of data sets the gene was present in
}
  \item{cutoff}{
percent of top hits which should be selected, default is set as 25 percent
}



}

\value{

output column  clus_... - logical information if gene was present in top percent cutoff.
Name includes information about cutoff value


}

\author{
Zofia Wicik
}

\examples{
#example####


#create input DF called DE_miRNA
miR<-c('hsa-miR-497-5p', 'hsa-miR-106a-5p', 'hsa-miR-195-5p', 'hsa-miR-4753-3p',
'hsa-miR-493-5p', 'hsa-miR-450b-5p', 'hsa-miR-448', 'hsa-miR-1264', 'hsa-miR-541-5p',
'hsa-miR-449b-5p', 'hsa-miR-493-3p', 'hsa-miR-4731-3p', 'hsa-miR-106a-3p', 'hsa-miR-345-5p',
'hsa-miR-3612', 'hsa-miR-1343', 'hsa-miR-1197', 'hsa-miR-1229-3p', 'hsa-miR-4766-3p',
'hsa-miR-580-3p', 'hsa-miR-345-3p', 'hsa-miR-4714-5p')
values_A<- c(66, 62, 54, 40, 34, 32, 32, 16, 15, 15, 15, 14, 14, 9,
9, 9, 9, 8, 5, 5, 4, 1)
values_B<- c(3, 5, 12, 14, 7, 7, 7, 1, 1, 13, 20, 12, 15,
6, 2, 2, 1, 12, 21, 10, 13, 3)

DE_miRNA<- data.frame(miR,values_A,values_B)


#set parameters
inputDF<- DE_miRNA
name_input_df="DE_miRNA"
landmark_col<- "miR"
cols_to_cluster<- c('values_A', 'values_B')
cutoff=20

#run function


temp<- top_percent(inputDF, landmark_col, cols_to_cluster, cutoff)



}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ clusterize }% use one of  RShowDoc("KEYWORDS")
\keyword{ prioritize }% __ONLY ONE__ keyword per line
