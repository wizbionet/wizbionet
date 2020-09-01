\name{cbind_filler}
\alias{cbind_filler}
\alias{wizbionet::cbind_filler}

\title{
Combine data frames and/or vectors filling in missing rows with NAs.

}
\description{
Alternative to cbind or cbind.fill. Enables combining multiplt different data frames or vectors
}
\usage{
cbind_filler(input)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{input}{
list of data frames or vectors
}



}

\value{
output is a combined data frame
}

\author{
Zofia Wicik
}

\examples{

#example data frame
dat1<- data.frame(miRNA=c('hsa-miR-195-5p', 'hsa-miR-4753-3p', 'hsa-miR-497-5p',
'hsa-miR-106a-5p', 'hsa-miR-195-5p', 'hsa-miR-4753-3p'), A=c(TRUE,TRUE,FALSE, TRUE, FALSE, FALSE))
dat2<- data.frame(miRNA=c('hsa-miR-195-5p', 'hsa-miR-4753-3p',
'hsa-miR-497-5p', 'hsa-miR-106a-5p'),  C=c(TRUE,TRUE,FALSE,FALSE))
dat3<- data.frame(miRNA=c('hsa-miR-195-5p', 'hsa-miR-4753-3p',
'hsa-miR-3612', 'hsa-miR-1343'),  D=c(TRUE,TRUE,FALSE,FALSE))
input<- list(dat1,dat2,dat3)
temp<- cbind_filler(input)



#example vectors of strings
dat1<-c('hsa-miR-195-5p', 'hsa-miR-4753-3p', 'hsa-miR-497-5p', 'hsa-miR-106a-5p', 'hsa-miR-195-5p')
dat2<-c('hsa-miR-497-5p', 'hsa-miR-106a-5p', 'hsa-miR-195-5p')
dat3<- data.frame(miRNA=c('hsa-miR-195-5p', 'hsa-miR-4753-3p',
'hsa-miR-3612', 'hsa-miR-1343'),  D=c(TRUE,TRUE,FALSE,FALSE))

input<- list(dat1,dat2,dat3)
temp<- cbind_filler(input)

}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory (show via RShowDoc("KEYWORDS")):
\keyword{ cbind }
\keyword{ bind dataframes }
% \keyword{ ~kwd2 }
% Use only one keyword per line.
% For non-standard keywords, use \concept instead of \keyword:
% \concept{ ~cpt1 }
% \concept{ ~cpt2 }
% Use only one concept per line.
