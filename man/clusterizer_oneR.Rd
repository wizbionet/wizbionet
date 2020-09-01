\name{clusterizer_oneR}
\alias{clusterizer_oneR}
\alias{wizbionet::clusterizer_oneR}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
easy data frame clustering
}
\description{
This functions enables comparison of data sets of different length.
It is suggested to use it on gene lists which have associated numeric values.
Prioritization of the analyzed gene lists can  based on the scores assigned after data aggregation and counting.
This function helps to avoid arbitrary selection of top candidates, by dividing the analyzed data set into four clusters using OneR package.
If clusters are too small it applies k-means clustering.
As top genes, we usually recognize genes present in the first two top clusters (cl1, cl2).





}
\usage{
clusterizer_oneR(inputDF,
landmark_col, cols_to_cluster)
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



}

\value{

output column  clus_... - logical information if gene was in top 2 clusters (cl1 and cl2) ~top 20 percents.

output column clusNR_... - information in which cluster the gene was present (cl1,cl2,cl3,cl4)
}
\references{
function utilizes OneR package: https://cran.r-project.org/web/packages/OneR/index.html

}
\author{
Zofia Wicik
}
\note{
if clusters are too small it will generate only two clusters
}


\examples{
#example####
#requires(OneR)


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


#run function
temp<- clusterizer_oneR(inputDF, landmark_col, cols_to_cluster)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ clusterize }% use one of  RShowDoc("KEYWORDS")
\keyword{ prioritize }% __ONLY ONE__ keyword per line
