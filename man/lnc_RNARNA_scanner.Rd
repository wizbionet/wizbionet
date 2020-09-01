\name{lnc_RNARNA_scanner}
\alias{lnc_RNARNA_scanner}
\alias{wizbionet::lnc_RNARNA_scanner}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{
lncRNA targets scrapper
}
\description{
This function identify targets of lncRNA by automatized mining of the
http://rtools.cbrc.jp/cgi-bin/RNARNA/index.pl  database using ENST ids.
As input for target prediction, function uses ENST transcript IDs (ENST_input)
and downloads top 500 (nr_top_genes) of the results with highest i) sumenergy ii) minenergy directly into R.
After identification of the lncRNAs it will check target overlap with our DE genes.
Finally, it filters out DE genes and combined obtained results with your expression data set/interesting transcripts(ENST_targets)


}
\usage{
lnc_RNARNA_scanner(ENST_input, analyze_onlyDEtargets, ENST_targets ,nr_top_genes)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{ENST_input}{
vector of characters (human ENST transcript numbers).
RNARNAdb will show information during the analysis if non coding transcript was present in the database. Careful, it sometimes also recognizes miRNAs.
}

  \item{analyze_onlyDEtargets}{
TRUE or FALSE (logical), it says if you want to check all possible lncRNA targets or only DE targets.
}

  \item{ENST_targets}{
vector of characters of human ENST numbers of your interest, usually DE mRNAs
}

  \item{nr_top_genes}{
numeric. Cutoff number for RNARNA database top targets output,
default set by us is 500. From this number function willextract your targets of interest
}




}

\value{
output is a list of data frames.

#Depending if analyze_onlyDEtargets= was set as TRUE
the output will be include list "lncRNA_DEtargets" which has only top DE targets of analyzed lncRNAs



#Depending if analyze_onlyDEtargets= was set as FALSE
the output will be include list "lncRNA_AllTargets" which has all possible top targets of analyzed lncRNAs

those two outputs have column ""full_id" which describes interacting RNAs with your lncRNAs
and provide a full name of the lncRNA for example: "List of RNAs interacting with ENST00000423793(RP11-432J22.2)".

You can use this column  for aggregating using col_agrecounter() and than clusterizer_oneR()
to obtain top lncRNAs or top targets.




#additionally output always has a list "result_lnc_RNAtoRNA_list"
which has complete results (including binding sites, location, rank) for each of the analyzed transcripts.
Each transcript has assigned two sub-lists "ENSTnumber_minEnergy" and "ENSTnumber_sumEnergy"
which were used for selection of the top targets

To access the lists use $ sign or[[]]
}
\references{
RNARNA.db creators: Terai G, Iwakiri J, Kameda T, Hamada M, Asai K.
Comprehensive prediction of lncRNA-RNA interactions in human transcriptome. BMC Genomics. 2016;17 Suppl 1(Suppl 1):12. Published 2016 Jan 11. doi:10.1186/s12864-015-2307-5
 http://rtools.cbrc.jp/cgi-bin/RNARNA/index.pl

}
\author{
Zofia Wicik
zofiawicik@gmail.com
}

\examples{

#Example
#requires(XML)
ENST_input<-c('ENST00000436290', 'ENST00000432892', 'ENST00000454526',
'ENST00000423793', 'ENST00000436960','ENST00000412754'
)

ENST_targets<-c('ENST00000491143', 'ENST00000314191',
'ENST00000309733', 'ENST00000377122', 'ENST00000338981',
'ENST00000495827', 'ENST00000425708', 'ENST00000272748',
'ENST00000336278', 'ENST00000282466', 'ENST00000260197',
'ENST00000265354', 'ENST00000422989', 'ENST00000280527',
'ENST00000342292', 'ENST00000426548', 'ENST00000340134',
'ENST00000396930', 'ENST00000373510', 'ENST00000262971',
'ENST00000341809', 'ENST00000357242', 'ENST00000271417',
'ENST00000323816', 'ENST00000392806', 'ENST00000238682',
'ENST00000398485', 'ENST00000422280', 'ENST00000376223', 'ENST00000237623')
nr_top_genes=500
analyze_onlyDEtargets=FALSE
output<- lnc_RNARNA_scanner (ENST_input, analyze_onlyDEtargets,
ENST_targets ,nr_top_genes)
names(output)


}
% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
\keyword{ lncRNA}% use one of  RShowDoc("KEYWORDS")
\keyword{ predictions }% __ONLY ONE__ keyword per line
