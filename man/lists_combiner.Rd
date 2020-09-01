\name{lists.combiner}
\alias{lists.combiner}
\alias{wizbionet::lists.combiner}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
function combining gene lists, alternative for Venn diagram
}
\description{
This function combines multiple gene lists together and summarizes occurrence of the string within a list.
Gene lists which will be combined should be a data frame (inputDF) of multiple gene/miRNAslists/or other stings.
Gene list in inputDF don't need to have equal length. Output provides logical information if gene (or other string) was present on given list.
After using this function you can try to use clusterizer_OneR() on first and last column.

}
\usage{
lists.combiner(inputDF)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{inputDF}{
inputDF is a data frame in which each column is a different gene list.
Gene lists in inputDF don't need to have equal length or be deduplicated.
inputDF need to have headings. It can be imported from txt file
}
}

\value{
Output provides logical information if gene (or other string) was present on given list,
and count of occurrences for each gene.
%%  If it is a LIST, use
%%  \item{comp1 }{Description of 'comp1'}
%%  \item{comp2 }{Description of 'comp2'}
%% ...
}

\author{
Zofia Wicik
}

\examples{

#example dataframe with gene lists
options(stringsAsFactors = FALSE)
GeneList1=c('PTGER3','FGFR1','ANO5','SGCD','CCKBR',
'PTGFR','NELL1','TBC1D8B','TGFB3')
GeneList2=c('CDH24','PAX1','PTGER3','TBC1D8B','TGFB3',
'PTGER3','NR2C2','NR2C2')
GeneList3=c('PTGER3','FGFR1','ONECUT2','NEBL','SNTB2',
'USP9Y','KAT6A','CRIM1',
'IGSF10','PRKDC','RAD23B','BRD1','PTPRM','PTGIS','RGS5',
'XIRP1','SPSB4')
GeneList4=c('PTGER3','FGFR1','GLIPR1','BCR','SMARCA2','MSMO1','FGF13','KALRN')
x<- list(GeneList1,	GeneList2, GeneList3,	GeneList4)
inputDF<- cbind_filler	(x)
names(inputDF)<-c('GeneList1',	'GeneList2', 'GeneList3',	'GeneList4' )
inputDF


#run function
output<- wizbionet::lists.combiner(inputDF)
head(output, n=3)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ combine }% use one of  RShowDoc("KEYWORDS")
\keyword{ merge }% __ONLY ONE__ keyword per line
