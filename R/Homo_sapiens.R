#' Homo Sapiens annotation file
#'
#' Data downloaded from ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz"
#' data were pre-processed by uncollapsing the rows. Created Jun. 2020
#'
#'
#'
#'
#' @format A data frame with columns:
#' \describe{
#'  \item{rows}{row number before uncollapsing}
#'  \item{Symbol}{official gene symbol}
#'  \item{all_synonyms}{all possible synonyms for a given gene}
#'  \item{GeneID}{Entrez ID}
#'  \item{ENSG_ID}{Ensembl gen ID}
#'  \item{HGNC_ID}{HGNC ID}
#' }
#'

#'
#' @references
#' (ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/Homo_sapiens.gene_info.gz)
#'
#' @source Homo Sapiens annotation, <https://ftp.ncbi.nlm.nih.gov/gene/DATA/GENE_INFO/Mammalia/>
#'
#' @examples
#' \dontrun{
#'  data(Homo_sapiens)
#' }
#'
#'
#'

"Homo_sapiens"
