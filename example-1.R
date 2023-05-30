# TAF example-1
# ref: https://github.com/ices-taf/doc/wiki/Example-datasets-1

library(icesTAF)

taf.skeleton("example-1")
setwd("example-1")
icesTAF::dir.tree()

# adding local file ------

# get R base data trees
data(trees)

# put data into boot/initial/data using write.taf
write.taf(trees, dir = "boot/initial/data")
## write trees data (csv) to boot/initial/data

# create the DATA.bib file
draft.data(
  data.files = "trees.csv",
  data.scripts = NULL,
  originator = "Ryan, T. A., Joiner, B. L. and Ryan, B. F. (1976) The Minitab Student Handbook. Duxbury Press.",
  title = "Diameter, Height and Volume for Black Cherry Trees",
  file = TRUE,
  append = FALSE # create a new DATA.bib
)

# taf.bootstrap: 
taf.bootstrap() #create a data repo
## the files in boot/data should be defined in DATA.bib (and gets from initial/data)

# adding local folder ------
# make a local collection
data(trees)
data(cars)
# make the directory we want to write to
mkdir("boot/initial/data/my-collection")
# save files there
write.taf(trees, dir = "boot/initial/data/my-collection")
write.taf(cars, dir = "boot/initial/data/my-collection")

icesTAF::dir.tree()


# create entry for folder instead of individual files
## running draft.data() only can gets everything in boot/initial/data

draft.data(
  data.files = "my-collection",
  data.scripts = NULL,
  originator = "R datasets package",
  title = "Collection of R data",
  source = "folder",
  file = TRUE,
  append = TRUE # add on to existing DATA.bib
)

# again add files, folders to boot/data
taf.bootstrap()

# NOTE: only files, folders defined in DATA.bib will be in boot/data repo (through taf.bootstrap())
## eg: a random file in boot/initial/data but not defined in DATA.bib -> not in boot/data

# adding a file from a URL ------

## create the entry of hadsst from url
draft.data(
  data.files = "HadSST.4.0.1.0_median.nc",
  data.scripts = NULL,
  originator = "UK MET office",
  title = "Met Office Hadley Centre observations datasets",
  year = 2022,
  source = "https://www.metoffice.gov.uk/hadobs/hadsst4/data/netcdf/HadSST.4.0.1.0_median.nc",
  file = TRUE,
  append = TRUE
)

taf.bootstrap() #add hadsst data to boot/data


# adding a via bootstrap script ------

# in case cannot download file directly, create a bootsrap script to fetch and process data
# save bootstrap script in folder boot 
cat('library(icesTAF)
library(sf)

download(
  "https://gis.ices.dk/shapefiles/OSPAR_Subregions.zip"
)

unzip("OSPAR_Subregions.zip")
unlink("OSPAR_Subregions.zip")

areas <- st_read("OSPAR_subregions_20160418_3857.shp")

# write as csv
st_write(
  areas, "ospar-areas.csv",
  layer_options = "GEOMETRY=AS_WKT"
)

unlink(dir(pattern = "OSPAR_subregions_20160418_3857"))
',
file = "boot/ospar-areas.R"
)

# entry to DATA.bib
draft.data(
  data.files = NULL,
  data.scripts = "ospar-areas.R",
  originator = "OSPAR",
  title = "OSPAR areas",
  file = TRUE,
  append = TRUE
)

# add file to boot/data
taf.bootstrap()

# check project dir
icesTAF::dir.tree()


# check if any package in the R script is not installed yet 
deps("boot", installed = FALSE) #in ospar-area.R there is sf package (might be not installed yet)
install.deps("boot") #install packages that need to be installed

# r script ices stock data --------
draft.data(
  data.files = NULL,
  data.scripts = "ices_stock-database.R",
  originator = "ICES",
  title = "ICES stock database",
  file = TRUE,
  append = TRUE
)

# boot
taf.bootstrap()

# note -------------
# check if any package in the R script is not installed yet 
deps("boot", installed = FALSE) #in ospar-area.R there is sf package (might be not installed yet)
install.deps("boot") #install packages that need to be installed


# NOTE: to make sure everything is right, try taf.bootstrap with taf = TRUE at the end
taf.bootstrap(taf = TRUE)



