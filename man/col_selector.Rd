\name{col_selector}
\alias{col_selector}
\alias{wizbionet::col_selector}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
select columns based on vectors

}
\description{
function for precise selecting/ reordering columns with similar names within a data frame.
It is suggested to use it after the function col_agrecounter() to select only columns of interest
}
\usage{
col_selector(inputDF, key_words)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{inputDF}{
data frame with headings and at least two columns
}

  \item{key_words}{
vector of characters to reorganize columns. Use special characters to extract key_words:
*=any character; ^=block beginning of the string , $=block end of the string

}
}

\value{
returns data freme with columns defined in key_words argument
}

\author{
Zofia Wicik
}
\note{
use Regular Expression Syntax to precisely select columns
}

\examples{
#example###
inputDF<-iris
names(inputDF)
key_words<-c("Species", "*Width", "*Length")
temp<-col_selector(inputDF,key_words)
names(temp) #width and lenght is now grouped together

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ select columns}% use one of  RShowDoc("KEYWORDS")
\keyword{ subset }% __ONLY ONE__ keyword per line
