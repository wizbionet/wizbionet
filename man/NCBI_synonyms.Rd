\name{NCBI_synonyms}
\alias{NCBI_synonyms}
\alias{wizbionet::NCBI_synonyms}

\title{
Automatic NCBI annotation for human gene lists
}
\description{
This function uses NCBI nomenclature which allows merging diffrent human gene lists using identical gene names.
It also provides Entrez genes IDs and ENSEMBL gene IDs. It utilizez pre-processed annotation file downloaded from
ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz .
}
\usage{
NCBI_synonyms(inputDF, input_col)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{inputDF}{
data frame with column containing gene symbols
}

  \item{input_col}{
name of the column containing gene symbols
}

}

\value{
output is a original data frame with additional columns "SymbolNCBI" ,"EntrezID"  , "ENSG_ID"
}
\references{
ftp://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz
}
\author{
Zofia Wicik
}
\examples{

inputDF<- data.frame(
symbols=c('ONECUT2','NEBL','SNTB2','USP9Y','KAT6A','CRIM1','IGSF10'),
values=c(0.01,0.5,0.05,0.001,0.9,0.03,0.06))
input_col<- "symbols"
output<-wizbionet::NCBI_synonyms(inputDF, input_col)
names(output)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ annotation}% use one of  RShowDoc("KEYWORDS")
\keyword{ NCBI}% __ONLY ONE__ keyword per line
