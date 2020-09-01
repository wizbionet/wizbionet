\name{venny.list}
\alias{venny.list}
\alias{wizbionet::venny.list}
\alias{vennylist}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
exporting gene list into clipboard
}
\description{
This simple functions deduplicates and exports vector or column to clipboard.
It was created to use together with the webpage http://bioinfogp.cnb.csic.es/tools/venny/ or paste to the excel or cytoscape
}
\usage{
venny.list(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
vector or column
}
}

\value{
list of strings, it prints its lenght in the terminal
}
\references{
https://bioinfogp.cnb.csic.es/tools/venny/
}
\author{
Zofia Wicik
}

\examples{
inputDF<- data.frame( symbols=c('ONECUT2','NEBL','SNTB2',
'USP9Y','KAT6A','CRIM1','IGSF10','NEBL'),
values=c(0.01,0.5,0.05,0.001,0.9,0.03,0.06,0.03))

venny.list(inputDF$symbols)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ venn }% use one of  RShowDoc("KEYWORDS")
\keyword{ writeclipboard }% __ONLY ONE__ keyword per line
