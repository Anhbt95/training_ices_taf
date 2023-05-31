library(icesTAF)

getwd()
setwd("ices_cat_5_template-main")

# developing a dataset (from DATA.bib)
taf.bootstrap()

# finalising a dataset
taf.boot(taf = TRUE)

# developing analysis sections
## install dependency
install.deps()

# source - running the individual .R files
sourceTAF("data")
sourceTAF("output")
sourceTAF("report")

# finalising an analysis 
sourceAll() #run again every .R files
