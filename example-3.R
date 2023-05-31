library(icesTAF)

getwd()
setwd("example-3")

# get example from github
run_dir <- download.analysis("ices-taf-dev/wiki-example-3", dir = ".")
browseURL(run_dir)

#run_dir
# run analysis
#run.analysis(run_dir)
# view result
#browseURL(run_dir)


# setwd
setwd("wiki-example-3-20230531-110252")

# developing a dataset (from DATA.bib)
taf.bootstrap()

# finalising a dataset
taf.boot(taf = TRUE)

# developing analysis sections
# source - running the individual .R files
sourceTAF("data")
sourceTAF("model")
sourceTAF("output")

# finalising an analysis 
sourceAll() #run again every .R files


# developing analysis -> taf.boot() repeatly 
# at the end do final check -> taf.boot(taf = TRUE)
# similarly, developing and finalise the analysis

