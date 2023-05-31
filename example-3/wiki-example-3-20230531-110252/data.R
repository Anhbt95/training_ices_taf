## Preprocess data, write TAF data tables

## Before:
## After:

library(icesTAF)

mkdir("data")

mkdir("output")

# load data
trees <- read.taf(taf.data.path("trees.csv"))

# normally there would be some processing here
# but this time we just write out the data we are
# using in the analysis

write.taf(trees, dir = "data")

cat("hello", file = "data/hello.txt")
cat("hello", file = "output/hello_ouput.txt")

# this is a comment

testplot <- "this will never work"

anotherplot <- "blah blah"

yetanotherplot <- "aha!"
