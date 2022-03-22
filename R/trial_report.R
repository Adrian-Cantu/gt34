#' render trial report
#'
#' @param df_file the path to a dataframe of intsites
#'
#' @export
trial_report <- function(df_file){

  rmarkdown::render(system.file('report_templates','trial_report.Rmd',package='gt34'),
    output_file = 'tttest',
    output_dir = '.',
    params = list('rds_file'=file.path(getwd(),df_file))
  )
}
