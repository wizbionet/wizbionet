\name{dataframe.merger}
\alias{dataframe.merger}
\alias{wizbionet::dataframe.merger}

\title{
data frame merger
}
\description{
Function for merging multiple data frames. Automatic merging of multiple data frames and preserving their names.
It was created to be utilized together with other functions from the package like col_selector(), col_agrecounter() etc.
}
\usage{
dataframe.merger(dataframe_list, ID_column)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{dataframe_list}{
list of data frames. Each of the data frames need to have a name, for example:
dataframe_list<-list("data1"=data1, 'data2'=data2) 'data3'=data3)
}

  \item{ID_column}{
same column shared across data frames which will be used for merging the files
}
}
\details{
#it utilizes function :
merge(data1, data2, by.x=ID_column, by.y=ID_column, all.x=TRUE, all.y=TRUE, suffixes = c("", ""))

}
\value{
output is a combined data frame with preserved names of each of merged data frames.
}

\author{
Zofia Wicik
}

\examples{
      #example
        dat1<- data.frame(miRNA=c('hsa-miR-497-5p', 'hsa-miR-106a-5p', 'hsa-miR-195-5p',
        'hsa-miR-4753-3p'), A=c(FALSE, TRUE, FALSE, FALSE))

        dat2<- data.frame(miRNA=c('hsa-miR-195-5p', 'hsa-miR-4753-3p','hsa-miR-497-5p',
        'hsa-miR-106a-5p'),  C=c(TRUE,TRUE,FALSE,FALSE))
        dat3<- data.frame(miRNA=c('hsa-miR-195-5p', 'hsa-miR-4753-3p','hsa-miR-3612',
        'hsa-miR-1343'),  D=c(TRUE,TRUE,FALSE,FALSE))


        dataframe_list<-list("dat1"=dat1, 'dat2'=dat2, 'dat3'=dat3)
        ID_column='miRNA'
        temp<- dataframe.merger(dataframe_list, ID_column)
names(temp)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ merge}% use one of  RShowDoc("KEYWORDS")
\keyword{ bind }% __ONLY ONE__ keyword per line
