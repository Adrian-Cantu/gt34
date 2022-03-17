#' CART insertion sites.
#'
#' A dataset containing insertion sites for two CART patients across several timepoints.
#'
#' @format A data frame with 13,066 rows and 28 variables:
#' \describe{
#'   \item{seqnames}{Chromosome}
#'   \item{start}{start position}
#'   \item{end}{end position (should be the same as start, it is here to be compatible with Granges)}
#'   \item{width}{width (should be 1, it is here to be compatible with Granges) }
#'   \item{strand}{which strand of DNA is the insertion located on}
#'   \item{refGenome}{reference genome}
#'   \item{reads}{Number of reads suporting this insertion site}
#'   \item{patient}{patien ID}
#'   \item{GTSP}{internal ID}
#'   \item{cellType}{Cell Type}
#'   \item{timePoint}{Time Point, free form format}
#'   \item{timePointDays}{Time Point (in days)}
#'   \item{timePointMonths}{Time Point (in months)}
#'   \item{posid}{Position ID in the format (Chromosome)(strand)(start)}
#'   \item{estAbund}{Number of unique clones, as define by SonicBreaks}
#'   \item{relAbund}{Relative abundance}
#'   \item{inFeature}{Whether the insertion is a gene}
#'   \item{nearestFeature}{Closes gene}
#'   \item{nearestFeatureStrand}{Strand of the nearest gene}
#'   \item{inFeatureExon}{whether the insertion is in an exon}
#'   \item{inFeatureSameOrt}{not sure...}
#'   \item{nearestFeatureDist}{Distance to nearest gene}
#'   \item{nearestOncoFeature}{Nearest Cancer related gene}
#'   \item{nearestOncoFeatureDist}{Distance to the nearest cancer related gene}
#'   \item{nearestOncoFeatureStrand}{Strand of the nearest cancer related gene}
#'   \item{nearestlymphomaFeature}{Neares Lymphoma related gene}
#'   \item{nearestlymphomaFeatureDist}{Distance to the nearest lymphoma related gene}
#'   \item{nearestlymphomaFeatureStrand}{Strand of the nearest lymphoma related gene}
#' }
#' @source Melenhorst, J.J. et al. (2022). Decade-long leukaemia remissions with persistence of CD4+ CAR T cells. Nature 1-7.
"intSitesCART"
