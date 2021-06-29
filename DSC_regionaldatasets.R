library(tidyverse)
library(readr)

getwd()
setwd("C:/Users/danielle.weissman/Documents/DSCS_Data")

# import abridged dataset and filter out observations shallower than 50 m
DSC_04142021_all_abridged <- read_csv("deep_sea_corals_abridged_record_04142021.csv") %>%
  filter(., shallowflag == 0)
str(DSC_04142021_all)

# dataframe of variable names to see what variables were chosen
variable_names <- data.frame(names(DSC_04142021_all)) %>%
  rename(., variable_names = names.DSC_04142021_all.)

# import whole dataset and filter out observations shallower than 50 m
# and change variable names to lowercase
DSC_04142021_all <- read_csv("deep_sea_corals_complete_record_04142021.csv") %>%
  filter(., ShallowFlag == 0) %>%
  rename_all(tolower) %>%
  select(c("scientificname", "verbatimscientificname", "vernacularnamecategory",
  "taxonrank", "phylum", "class", "order", "family", "genus", "synonyms",
  "fishcouncilregion", "locality", "latitude", "longitude", "depthinmeters",
  "observationdate", "observationyear", "samplingequipment", "locationaccuracy",
  "vehiclename", "surveyid", "recordtype", "sampleid"))



# get names of RFMCS
unique(DSC_04142021_all$fishcouncilregion)
# "South Atlantic"  "Gulf of Mexico"  NA                "New England"     "Mid-Atlantic"   
# "Caribbean"       "North Pacific"   "Pacific"         "Western Pacific"


# Create individual datasets for each region and write to .csv files
DSC_SouthAtlantic <- DSC_04142021_all %>%
  filter(fishcouncilregion == "South Atlantic") %>%
  write_csv(., "DSC_SouthAtlantic_04142021.csv")

DSC_GulfofMexico <- DSC_04142021_all %>%
  filter(fishcouncilregion == "Gulf of Mexico") %>%
  write_csv(., "DSC_GulfofMexico_04142021.csv")

DSC_USCaribbean <- DSC_04142021_all %>%
  filter(fishcouncilregion == "Caribbean") %>%
  write_csv(., "DSC_USCaribbean_04142021.csv")
  

DSC_MidAtlantic <- DSC_04142021_all %>%
  filter(fishcouncilregion == "Mid-Atlantic") %>%
  write_csv(., "DSC_MidAtlantic_04142021.csv")

DSC_NewEngland <- DSC_04142021_all %>%
  filter(fishcouncilregion == "New England") %>%
  write_csv(., "DSC_NewEngland_04142021.csv")

DSC_Pacific <- DSC_04142021_all %>%
  filter(fishcouncilregion == "Pacific") %>%
  write_csv(., "DSC_Pacific_04142021.csv")

DSC_NorthPacific <- DSC_04142021_all %>%
  filter(fishcouncilregion == "North Pacific") %>%
  write_csv(., "DSC_NorthPacific_04142021.csv")

DSC_WesternPacific <- DSC_04142021_all %>%
  filter(fishcouncilregion == "Western Pacific") %>%
  write_csv(., "DSC_WesternPacific_04142021.csv")

# Southeast U.S. SEDCI dataframe
DSC_Southeast <- Reduce(function(x, y) merge(x, y, all=TRUE),
                        list(DSC_SouthAtlantic, DSC_GulfofMexico, DSC_USCaribbean)) %>%
  write_csv(., "DSC_Southeast_04142021.csv")
