
#' Calculate the UC50 (the number of unique clones which make up the top 50% of the sample's
#' abundance) from a vector clonal abundances.
#'
#' @param abund numeric vector of clonal abundances
#'
#' @return UC50
calculateUC50 <- function(abund){
  stopifnot(is.vector(abund) & is.numeric(abund))
  abund <- abund[order(abund)]
  accum <- sapply(1:length(abund), function(i){sum(abund[1:i])})
  length(accum[accum >= sum(abund)/2])
}


#' Calculate population metric for an intSite dataframe. Will combine samples with the same timePoint,
#' cellType and patient
#'
#' @param dd An intSite dataframe
#' @return A dataframe
#' @importFrom rlang .data
#' @importFrom magrittr %>%
#' @export
get_pop_metrics <- function(dd) {
  pop_stats <- dd %>%
    #  mutate(timePoint=tolower(timePoint)) %>%
    dplyr::group_by(.data$timePointDays,.data$timePoint,.data$cellType,.data$patient) %>%
    #  mutate(within_gene=ifelse(nearest_geneDist == 0, TRUE, FALSE)) %>%
    dplyr::summarise(
      "numUniqSites" = dplyr::n(),
      #    "estAbund_avg" = mean(estAbund),
      "maxRelAbund" = max(.data$relAbund),
      "numClones" = sum(.data$estAbund),
      "Shannon" = vegan::diversity(.data$estAbund),
      "Gini" = reldist::gini(.data$estAbund),
      "Chao1" = round(vegan::estimateR(.data$estAbund, index='chao')[2], 0),
      "Simpson" = round(1-vegan::diversity(.data$estAbund, index = "simpson"),digits=3),
      "UC50" = calculateUC50(.data$estAbund),
      .groups = 'drop'
    )
}


#' Calculate population metric for an intSite dataframe. Will NOT combine samples with the same
#' timePoint, cellType and patient.
#'
#' @param dd An intSite dataframe
#' @param round Integer. the number of significant digits to show for maxRelAbund, Shannon, Gini,
#' and Simpson
#'
#' @return A dataframe
#' @export
get_pop_metrics_gtsp <- function(dd, round=3) {
  pop_stats <- dd %>%
    #  mutate(timePoint=tolower(timePoint)) %>%
    dplyr::group_by(.data$GTSP,.data$timePointDays,.data$timePoint,.data$cellType,.data$patient) %>%
    #  mutate(within_gene=ifelse(nearest_geneDist == 0, TRUE, FALSE)) %>%
    dplyr::summarise(
      "numUniqSites" = dplyr::n(),
      #    "estAbund_avg" = mean(estAbund),
      "maxRelAbund" = paste0(as.character(round(max(.data$relAbund),digits = 2)),'%'),
      "numClones" = sum(.data$estAbund),
      "Shannon" = round(vegan::diversity(.data$estAbund),digits = round),
      "Gini" = round(reldist::gini(.data$estAbund),digits = round),
      "Chao1" = round(vegan::estimateR(.data$estAbund, index='chao')[2], 0),
      "Simpson" = round(1-vegan::diversity(.data$estAbund, index = "simpson"),digits=round),
      "UC50" = calculateUC50(.data$estAbund),
      .groups = 'drop'
    )
}
