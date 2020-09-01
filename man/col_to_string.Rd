\name{col_to_string}
\alias{col_to_string}
\alias{wizbionet::col_to_string}

\title{
column to string
}
\description{
This simple functions transforms and deduplicates column from the dataframe into vector of stings
}
\usage{
col_to_string(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
column from the data frame
}
}

\value{
it generates vector of strings
}

\author{
Zofia Wicik
}

\examples{

inputDF<- data.frame( symbols=c('ONECUT2','NEBL','SNTB2','USP9Y',
'KAT6A','CRIM1','IGSF10','NEBL','IGSF10'),
                      values=c(0.01,0.5,0.05,0.001,0.9,
                      0.03,0.06,0.03, 0.001))
col_to_string(inputDF$symbols)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ column to string  }% use one of  RShowDoc("KEYWORDS")
\keyword{ data frame to vector}% __ONLY ONE__ keyword per line
