\name{col_agrecounter}
\alias{col_agrecounter}
\alias{wizbionet::col_agrecounter}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
data frame aggregator
}

\description{
This function allows to aggregates and summarize complex data frames with preserving
names of the columns and providing the number of occurrences column "_count".

}
\usage{
col_agrecounter(inputDF, col_names, col_collapse , rows_collapse, control_col)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{inputDF}{
data frame for aggregation and counting (A&C)
}

 \item{col_names}{
column names which will be A&C
}

 \item{col_collapse}{
landmark column for columns which will A&C
}

 \item{rows_collapse}{
vector of characters<- content of the landmark column (col_collapse=).
It can be easy generated using function wizbionet::col_to_string()
}


 \item{control_col}{
additional landmark column which doesn't allow to deduplicate data based on column col_collapse=.
For example when we have different transcripts for a gene and we want to preserve this information
}



}

\value{
output provides input data frame with additional columns in which rows were aggregated.
For each aggregated column it provides two columns with suffixes "_coll" and "_count".
Column with suffix "_coll" has aggregated strings (gene) for example: "CDH24|ONECUT2|PAX1|PTGER3".
Column with suffix "_count" has numbers of items from column "_coll".
Output is sorted based on the counts from the control_col= .
After using this function you can try to use clusterizer_OneR() or top_percent() on col_collapse= and column with suffix _COUNT
}

\author{
Zofia Wicik
}

\examples{
#Example
dat1<- data.frame(
  mature_miRNA=c('hsa-miR-195-5p', 'hsa-miR-195-3p','hsa-miR-195-5p', 'hsa-miR-195-5p',
                 'hsa-miR-4753-5p', 'hsa-miR-4753-3p'),
  pre_miRNA=c('hsa-miR-195', 'hsa-miR-195','hsa-miR-195', 'hsa-miR-195',
              'hsa-miR-4753', 'hsa-miR-4753'),
  Target=c('CDH24',	'PAX1',	'PTGER3',	'ONECUT2',	'TGFB3',	'FGFR1'))


#set parameters####

#dataframe for aggegation and counting (A&C)
    inputDF<-dat1
#selected column names which will be A&C
    col_names <- c( "Target")
#landmark column for A&C columns,other columns will be aggregated based on this
    col_collapse <- "pre_miRNA"
#vector of content of the landmark column "col_collapse" as vector.
#You can use internal col_to_string() function

    rows_collapse <-col_to_string(inputDF$pre_miRNA)
#additional landmark column which will not allow to deduplicate.
#Useful when you want to analyze pre-miRNAs instead of mature mirNAs
    control_col<- "mature_miRNA"

#run function
output<- col_agrecounter(inputDF, col_names, col_collapse , rows_collapse, control_col)
}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ aggregate }% use one of  RShowDoc("KEYWORDS")
\keyword{ summarize }% __ONLY ONE__ keyword per line
