# Code provided by Sam Strauss in LDP course
# 20220917


# Check for R packages to install

RequiredPackages <- c("rdryad")
for (i in RequiredPackages) { #Installs packages if not yet installed
  if (!require(i, character.only = TRUE)) install.packages(i)}

# Download libraries
library(rdryad)

# Create folder directories

dir.create("data/")
dir.create("scripts/")
dir.create("images")
dir.create("data/url")
dir.create("data/dryad")
dir.create("data/github")

#download from URL
data.url <- "https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrateDensity.csv"
metadata.url <-"https://ftp.maps.canada.ca/pub//nrcan_rncan/Forests_Foret/TLW/TLW_invertebrate_metaEN.csv"

data.dest.file <- "data/url/NRCAN_1995_2009_TLW_invert_density.csv"
metadata.dest.file <- "data/url/NRCAN_1995_2009_TLW_invert_density_metadata.csv"

download.file(url = data.url, destfile = data.dest.file)
download.file(url = metadata.url, destfile = metadata.dest.file)
invert.density <- read.csv("data/url/NRCAN_1995_2009_TLW_invert_density.csv")
View(invert.density)
Sys.Date()

#dryad
# doi : https://doi.org/10.5061/dryad.8931zcrnh
rdryad::dryad_get_cache()

#setting custom cache location
#https://github.com/ropensci/rdryad/pull/36
rdryad.cache <- rdryad::dryad_get_cache()
rdryad.cache$cache_path_set(full_path = normalizePath("data/dryad", mustWork = FALSE))
rdryad_cache&cache_path_get()
# rdryad_cache$mkdir()
# rdryad::dryad_set_cache(rdryad_cache)
dryad_download(dois = "10.5061/dryad.8931zcrnh")

#github
dir.create("Beta_div/")
# https://github.com/kguidonimartins/betadiv-enp.git
usethis::create_from_github(repo_spec = "https://github.com/kguidonimartins/betadiv-enp.git",
                            destdir="Beta_div")
system("cp -r Beta_div/betadiv-enp/data/* data/github/.")
