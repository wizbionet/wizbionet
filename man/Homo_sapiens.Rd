% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/Homo_sapiens.R
\docType{data}
\name{Homo_sapiens}
\alias{Homo_sapiens}
\title{Homo Sapiens annotation file}
\format{
A data frame with columns:
\describe{
 \item{rows}{row number before uncollapsing}
 \item{Symbol}{official gene symbol}
 \item{all_synonyms}{all possible synonyms for a given gene}
 \item{GeneID}{Entrez ID}
 \item{ENSG_ID}{Ensembl gen ID}
 \item{HGNC_ID}{HGNC ID}
}
}
\source{
Homo Sapiens annotation, <https://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/>
}
\usage{
Homo_sapiens
}
\description{
Data downloaded from ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz"
data were pre-processed by uncollapsing the rows. Created Jun. 2020
}
\examples{
\dontrun{
 data(Homo_sapiens)
}



}
\references{
(ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz)
}
\keyword{datasets}
