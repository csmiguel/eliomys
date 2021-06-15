#######################################
## DOWNLOAD AND CLEAN DATA FROM GBIF ##
#######################################
library(rgbif)
library(scrubr)
library(maps)
library(dplyr)


# IF YOU HAVE ONLY ONE SPECIES ----

myspecies <- c("Eliomys quercinus")

# download GBIF occurrence data for this species; this takes time if there are many data points!
# I retrieve data not from the atlas
gbif_data <- occ_data(scientificName = myspecies,
                      country = "ES;PT",
                      hasCoordinate = TRUE,
                      limit = 20000,
                      year = "2007,2021")

# take a look at the downloaded data:
gbif_data

# get the DOIs for citing these data properly:
gbif_citation(gbif_data)
# note: if you need or prefer only one DOI for the entire dataset, download the dataset directly from www.gbif.org and then import the .csv to R. It is very important to properly cite the data sources! GBIF is not a source, just a repository for many people who put in very hard work to collect these data and make them available

# check how the data are organized:
names(gbif_data)
names(gbif_data$meta)
names(gbif_data$data)

# get the columns that matter for mapping and cleaning the occurrence data:
equercinus <-
  gbif_data$data %>%
  dplyr::select("decimalLongitude", "decimalLatitude", "individualCount", "occurrenceStatus", "coordinateUncertaintyInMeters", "institutionCode", "references", "year", "collectionCode")

#clean dataset
absence_rows <- which(equercinus$individualCount == 0 | equercinus$occurrenceStatus %in% c("absent", "Absent", "ABSENT", "ausente", "Ausente", "AUSENTE"))
equercinus_coords_present <- equercinus[-absence_rows, ]

#check no weird strings
table(equercinus_coords_present$individualCount)
table(equercinus_coords_present$occurrenceStatus)

# let's do some further data cleaning with functions of the 'scrubr' package (but note this cleaning is not exhaustive!)
eq_clean <-
  equercinus_coords_present %>%
    coord_unlikely() %>%
    coord_impossible() %>%
  coord_imprecise() %>%
  coord_incomplete() %>%
  coord_uncertain(coorduncertainityLimit = 30000)

table(eq_clean$collectionCode)
dset <- eq_clean$institutionCode == "ARM"

# map the occurrence data:
# if the map doesn't appear right at first, run this command again
map("world",
    xlim = range(eq_clean$decimalLongitude),
    ylim = range(eq_clean$decimalLatitude))
title("GBIF records Iberia E. quercinus 2007-2021")
#points not ARM
points(eq_clean[dset, c("decimalLongitude", "decimalLatitude")],
       pch = ".",
       cex = 2.5, col = "grey50")
#other dataset
points(eq_clean[dset2, c("decimalLongitude", "decimalLatitude")],
       pch = ".",
       cex = 2.5,
       col = "red")
legend("bottomright",
       legend = c("MITECO-2007", "other sources"),
       fill = c("black", "red"),
       cex = 0.7, box.col = "white")

eq_clean[dset2,] %>% pull(year) %>% table() %>% plot
