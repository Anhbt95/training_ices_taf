# TAF example-1
# ref: https://github.com/ices-taf/doc/wiki/Example-datasets-2

library(icesTAF)

taf.skeleton("example-2")
setwd("example-2")
dir.tree()


# add SAM input data via a boot script -----

# model from stockassessment.org
cat('library(stockassessment)

# download model from stockassessment.org
fit <- fitfromweb("WBCod_2021_cand01")

# save to model folder
save(fit, file = "fit.rData")

',
    file = "boot/sam_fit.R"
)

# dir tree
dir.tree()


# data from stockassessment.org
cat('sam_assessment <- "WBCod_2021_cand01"

sam_dir <-
  paste0(
    "https://stockassessment.org/datadisk/stockassessment/userdirs/user3/",
    sam_assessment,
    "/data/"
  )

files <-
  paste0(
    c("cn", "cw", "dw", "lf", "lw", "mo", "nm", "pf", "pm", "survey", "sw"),
    ".dat"
  )

for (file in files) {
  download(paste0(sam_dir, file))
}

',
file = "boot/sam_data.R"
)

# create entries in DATA.bib
draft.data(
  data.files = NULL,
  data.scripts = c("sam_data", "sam_fit"),
  originator = "WGBFAS",
  title = c("SAM input data for ...", "SAM fitted object for ..."),
  year = 2021,
  period = "1985-2020",
  file = TRUE,
  append = FALSE
)

# check packages
# check if any package in the R script is not installed yet 
deps("boot", installed = FALSE) 
install.deps("boot") #install packages that need to be installed


# boot
taf.boot()

