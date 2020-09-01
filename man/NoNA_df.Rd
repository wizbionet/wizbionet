\name{NoNA.df}
\alias{NoNA.df}
\alias{NoNA_df}
\alias{wizbionet:NoNA.df}

\title{
missing values into NAs
}
\description{
This functions changes all kinds of missing values into NAs ("", NULL", "NaN" etc)
}
\usage{
NoNA.df(x)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{
data frame
}
}

\value{
data frame will have missing values replaced with NAs
}

\author{
Zofia Wicik
}

\examples{
inputDF<- data.frame( symbols=c('ONECUT2','NEBL','NaN','-','KAT6A','','IGSF10','NEBL'),
values=c(0.01,0.5,0.05,0.001,0.9,0.03,0.06,0.03))
NoNA.df(inputDF)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ NA}% use one of  RShowDoc("KEYWORDS")
\keyword{ !is.na }% __ONLY ONE__ keyword per line
