\name{topmiRNA_toptarget}
\alias{topmiRNA_toptarget}
\alias{topmiRNA_toptarget}
\alias{wizbionet::topmiRNA_toptarget}

%- Also NEED an '\alias' for EACH other topic documented here.
\title{
Prioritizes microRNA-target interactions from the the multiMiR Package
}
\description{
This function retrieves miRNA-target interactions and and identify miRNAs and genes with highest number of analyzed interactors.
}
\usage{
topmiRNA_toptarget(DEmir_up,DEgenes_down,DEmir_down,
DEgenes_up, multimir_args, mirna_type)

}
%- maybe also 'usage' for other objects documented here.
\arguments{


  \item{DEmir_up}{
vector with up-regulated miRNAs. To see ID examples see help(get_multimir) and field mirna= .
If you don't want to define miRNA put NULL than multimir will analyze all possible pairs
}

  \item{DEgenes_down}{
vector with down-regulated genes. To see ID examples examples see help(get_multimir) and field target= .
If you don't want to define targets put NULL than multimir will analyze all possible pairs
}

  \item{DEmir_down}{
vector with down-regulated miRNAs
}

  \item{DEgenes_up}{
vector with up-regulated genes
}

\item{mirna_type}{
"mature_mir" or "pre_mir" mirna_type will be used for deduplication and data aggregation
}


  \item{multimir_args}{
#This parameter is a component of the multiMiR::get_multimir function .
You can see description using command:
help(get_multimir)
#You can  modify all components using
multimir_args<- as.list(args(multiMiR::get_multimir))

#Important: Don't add mirna=  and  target= fields they are already included as DEmir_up,DEgenes_down,DEmir_down, DEgenes_up!

}






}

\value{
This function generates a list with three data frames
1) multimir_output - is a data frame with results from get_multimir function.
It provides information about up and down-regulation of the pairs miRNA-targets.
It can by used for constructing interaction network in the cytoscape

2) top_miR - is a data frame with aggregated and prioritized results from get_multimir function showing number of genes associated with pre miRNAs
It has columns with name clus_... providing logical information if gene was in top 2 clusters (cl1 and cl2)
~top 20 percents and  column clusNR_... providing information in which cluster the gene was present (cl1,cl2,cl3,cl4).

2) top_gene - is a data frame with aggregated and prioritized results from get_multimir function showing number of genes associated with analyzed targets. It also has columns with information if gene if in top cluster


}
\references{
Ru Y, Kechris KJ, Tabakoff B, Hoffman P, Radcliffe RA, Bowler R, Mahaffey S, Rossi S, Calin GA, Bemis L, Theodorescu D (2014). “The multiMiR R package and database: integration of microRNA–target interactions along with their disease and drug associations.” Nucleic Acids Research, 42(17), e133. doi: 10.1093/nar/gku631, http://dx.doi.org/10.1093/nar/gku631.

Ru Y, Mulvahill M, Mahaffey S, Kechris K. multiMiR: Integration of multiple microRNA-target databases with their disease and drug associations. https://github.com/KechrisLab/multiMiR.


}
\author{
Zofia Wicik
zofiawicik@gmail.com
}

\examples{
#Example###

#set parameters
DEmir_up<-c('hsa-miR-150-5p','hsa-miR-448-5p','hsa-miR-448-3p',
'hsa-miR-493-5p','hsa-miR-493-3p') # example DE miRNAs
DEgenes_down<-c('5797','8826','7994','2775','7182','79647','5733',
'158158','9480','8626','50636') # example DE genes
DEmir_down<-c('hsa-miR-4731-5p','hsa-miR-541-3p','hsa-miR-449b-5p','hsa-miR-541-5p')
DEgenes_up<-c('203859','4745','4916','126298','2258','8464','55917','23450','29767')
mirna_type<-"pre_mir" # "mature_mir"
multimir_args= list(url = NULL,
                    org = "hsa",
                    table = "all",
                    predicted.cutoff = 10,
                    predicted.cutoff.type = "p",
                    predicted.site = "conserved"
)

#execute function
output<- wizbionet::topmiRNA_toptarget(DEmir_up,DEgenes_down,
DEmir_down, DEgenes_up, multimir_args,mirna_type)



}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ miRNA}% use one of  RShowDoc("KEYWORDS")
\keyword{ predictions }% __ONLY ONE__ keyword per line
