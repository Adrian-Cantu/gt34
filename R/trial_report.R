rmarkdown::render(system.file('report_template','trial_report.Rmd',package='gt34'),
                  output_file = 'tttest',
                  output_dir = '.',
                  #intermediates_dir='.',
                  params = list('rds_file'=file.path(getwd(),'Gill_intSites.rds'))
                 )
