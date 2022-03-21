#' Get current document format.
#'
#' @return The current document format, might be live (for Rstudio), latex or html.
get_doc_format <- function(){
  if (is.null(knitr::opts_knit$get("rmarkdown.pandoc.to"))) {
    doc_format <- 'live'
  } else {
    doc_format <-  knitr::opts_knit$get("rmarkdown.pandoc.to")
  }
  return(doc_format)
}


#' Print single page table
#'
#' @param table a dataframe
#' @param doc_format print format, might be live (for Rstudio), latex or html
#'
#' @return strings to print the table
#' @export
print_table <- function(table,doc_format=get_doc_format()) {
  if (doc_format=='live') {
    table
  } else if (doc_format=='latex') {
    table %>%
      kableExtra::kable( "latex", booktabs = TRUE) %>%
      kableExtra::kable_styling(latex_options = c("HOLD_position","striped"))
  } else if (doc_format=='html'){
    table %>%
      kableExtra::kable( "html") %>%
      kableExtra::kable_paper("hover", full_width = F)
  }
}

#' print a multiple page table
#'
#' @param table a dataframe.
#' @param doc_format print format, might be live (for Rstudio), latex or html
#' @param font_size font size, the default is 7, might need a smaller font to fit long rows
#' @param stripe_index A numeric vector describing which rows should be shaded. default if every other row
#' @param linesep A string vector describing spacing between rows
#'
#' @return strings to print the table
#' @importFrom rlang .data
#' @export
print_table_long <- function(table,doc_format='live',font_size=7,
                             stripe_index=NULL,
                             linesep=(if (.data$booktabs) c("", "", "", "", "\\addlinespace") else "\\hline")) {
  if (doc_format=='live') {
    table
  } else if (doc_format=='latex') {
    table %>%
      kableExtra::kbl("latex", booktabs = TRUE, longtable = TRUE,linesep=linesep) %>%
      kableExtra::kable_styling(latex_options = c("HOLD_position","repeat_header","striped"),
                    font_size = font_size,stripe_index = stripe_index)
  } else if (doc_format=='html'){
    table %>%
      kableExtra::kbl( "html") %>%
      kableExtra::kable_paper("hover", full_width = F)
  }
}

#' print nice sample table
#'
#' @param table a dataframe
#'
#' @return latex table
#' @importFrom rlang .data
#' @export
ppf_table <- function(table){
  table_insites <- table %>%
    dplyr::mutate(cellType=cellTypeControlVoc2(.data$cellType)) %>%
    get_pop_metrics_gtsp() %>%
    dplyr::arrange(.data$patient,.data$timePointDays,.data$cellType)

  tt_strip <- which(as.logical(as.numeric(as.factor(table_insites$patient)) %% 2))

  tt_l2 <- tt_l1 <- as.logical(as.numeric(as.factor(table_insites$patient)) %% 2)
  tt_l2[length(tt_l2)+1]<-tt_l2[length(tt_l2)]
  tt_l2 <- tt_l2[2:length(tt_l2)]

  tt_lspace <- ifelse(xor(tt_l1,tt_l2),"\\addlinespace","")
  table_insites %>%
    dplyr::rename("Time(d)"=.data$timePointDays) %>%
    dplyr::relocate(.data$numClones,.after = .data$patient) %>%
    dplyr::rename("Clones"=.data$numClones) %>%
    dplyr::rename("Unique"=.data$numUniqSites) %>%
    dplyr::rename("Max Clone"=.data$maxRelAbund) %>%
    kableExtra::kbl("latex", booktabs = TRUE, longtable = TRUE,linesep=tt_lspace) %>%
    kableExtra::add_header_above(c("Sample Info"=5, "Clone info" = 3, "Population info" = 5)) %>%
    kableExtra::kable_styling(latex_options = c("HOLD_position","repeat_header","striped"),
                  font_size = 5,stripe_index = tt_strip)

}
