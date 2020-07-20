# load packages -----------------------------------------------------------
library("dplyr")
library("tidyverse")
library("readxl")
library("janitor")
library("tidyUSDA")

# USDA key ----------------------------------------------------------------
key <- '402BA5AF-8117-3EBC-89F8-837F070C47C1'


# usda data function ------------------------------------------------------

usda_data <- function(data_item, data_year) {
  tidyUSDA::getQuickstat(
    sector=NULL,
    group=NULL,
    commodity=NULL,
    category=NULL,
    domain='TOTAL',
    county=NULL,
    key = key,
    program = 'CENSUS',
    data_item = data_item, #data_item argument, e.g. 'HOGS - INVENTORY'
    geographic_level = 'COUNTY',
    year = data_year, #data_year argument
    state = NULL,
    geometry = TRUE,
    lower48 = FALSE)
}

# egg layer data ----------------------------------------------------------

layer_inventory_2017 <-usda_data("CHICKENS, LAYERS - INVENTORY", "2017") %>% 
  clean_names()
layer_inventory_2012 <-usda_data("CHICKENS, LAYERS - INVENTORY", "2012") %>% 
  clean_names()
layer_inventory_2007 <-usda_data("CHICKENS, LAYERS - INVENTORY", "2007") %>% 
  clean_names()
layer_inventory_2002 <-usda_data("CHICKENS, LAYERS - INVENTORY", "2002") %>% 
  clean_names()
layer_inventory_1997 <-usda_data("CHICKENS, LAYERS - INVENTORY", "1997") %>% 
  clean_names()

usda_layer_inventory_1997_2017 <- rbind(layer_inventory_2017,
                                   layer_inventory_2012,
                                   layer_inventory_2007,
                                   layer_inventory_2002,
                                   layer_inventory_1997)

# nix the unwanted columns
usda_layer_inventory_1997_2017 <- usda_layer_inventory_1997_2017 %>%
  select(-contains("end_code")) %>%
  select(-contains("domaincat_desc")) %>%
  select(-contains("load_time")) %>%
  select(-contains("week_ending")) %>%
  select(-contains("sector_desc")) %>%
  select(-contains("begin_code")) %>%
  select(-contains("congr")) %>%
  select(-contains("period")) %>%
  select(-contains("group_desc")) %>%
  select(-contains("country")) %>%
  select(-contains("week")) %>% 
  select(-contains("district")) %>% 
  select(-contains("zip")) %>%
  select(-contains("class")) %>%
  select(-contains("region")) %>% 
  select(-contains("watershed_code")) %>% 
  select(-contains("util")) %>% 
  select(-contains("data")) %>%
  select(-contains("location_desc")) %>%
  select(-contains("cv"))

# cattle data -------------------------------------------------------------

cattle_inventory_2017 <-usda_data("CATTLE, COWS - INVENTORY", "2017") %>%
  clean_names()
cattle_inventory_2012 <-usda_data("CATTLE, COWS - INVENTORY", "2012") %>% 
  clean_names()
cattle_inventory_2007 <-usda_data("CATTLE, COWS - INVENTORY", "2007") %>% 
  clean_names()
cattle_inventory_2002 <-usda_data("CATTLE, COWS - INVENTORY", "2002") %>% 
  clean_names()
cattle_inventory_1997 <-usda_data("CATTLE, COWS - INVENTORY", "1997") %>% 
  clean_names()

usda_cattle_inventory_1997_2017 <- rbind(cattle_inventory_2017,
                                    cattle_inventory_2012,
                                    cattle_inventory_2007,
                                    cattle_inventory_2002,
                                    cattle_inventory_1997)

# nix the unwanted columns
usda_cattle_inventory_1997_2017 <- usda_cattle_inventory_1997_2017 %>%
  select(-contains("end_code")) %>%
  select(-contains("domaincat_desc")) %>%
  select(-contains("load_time")) %>%
  select(-contains("week_ending")) %>%
  select(-contains("sector_desc")) %>%
  select(-contains("begin_code")) %>%
  select(-contains("congr")) %>%
  select(-contains("period")) %>%
  select(-contains("group_desc")) %>%
  select(-contains("country")) %>%
  select(-contains("week")) %>% 
  select(-contains("district")) %>% 
  select(-contains("zip")) %>%
  select(-contains("class")) %>%
  select(-contains("region")) %>% 
  select(-contains("watershed_code")) %>% 
  select(-contains("util")) %>% 
  select(-contains("data")) %>%
  select(-contains("location_desc")) %>%
  select(-contains("cv"))
# hog data ----------------------------------------------------------------

hog_inventory_2017 <- usda_data("HOGS - INVENTORY", "2017") %>% 
  clean_names()
hog_inventory_2012 <- usda_data("HOGS - INVENTORY", "2012") %>% 
  clean_names()
hog_inventory_2007 <- usda_data("HOGS - INVENTORY", "2007") %>% 
  clean_names()
hog_inventory_2002 <- usda_data("HOGS - INVENTORY", "2002") %>% 
  clean_names()
hog_inventory_1997 <- usda_data("HOGS - INVENTORY", "1997") %>% 
  clean_names()

# bind the hog data together
usda_hog_inventory_1997_2017 <- rbind(hog_inventory_2017,
                                      hog_inventory_2012,
                                      hog_inventory_2007,
                                      hog_inventory_2002,
                                      hog_inventory_1997) 
# nix the unwanted columns
usda_hog_inventory_1997_2017 <- usda_hog_inventory_1997_2017 %>%
  select(-contains("end_code")) %>%
  select(-contains("domaincat_desc")) %>%
  select(-contains("load_time")) %>%
  select(-contains("week_ending")) %>%
  select(-contains("sector_desc")) %>%
  select(-contains("begin_code")) %>%
  select(-contains("congr")) %>%
  select(-contains("period")) %>%
  select(-contains("group_desc")) %>%
  select(-contains("country")) %>%
  select(-contains("week")) %>% 
  select(-contains("district")) %>% 
  select(-contains("zip")) %>%
  select(-contains("class")) %>%
  select(-contains("region")) %>% 
  select(-contains("watershed_code")) %>% 
  select(-contains("util")) %>% 
  select(-contains("data")) %>%
  select(-contains("location_desc")) %>%
  select(-contains("cv"))

# chicken broiler data ----------------------------------------------------

# run function to get dataframe for each year
broiler_inventory_2017 <- usda_data("CHICKENS, BROILERS - INVENTORY", "2017") %>% 
  clean_names()
broiler_inventory_2012 <- usda_data("CHICKENS, BROILERS - INVENTORY", "2012") %>% 
  clean_names()
broiler_inventory_2007 <- usda_data("CHICKENS, BROILERS - INVENTORY", "2007") %>% 
  clean_names()
broiler_inventory_2002 <- usda_data("CHICKENS, BROILERS - INVENTORY", "2002") %>% 
  clean_names()
broiler_inventory_1997 <- usda_data("CHICKENS, BROILERS - INVENTORY", "1997") %>% 
  clean_names()

# bind the data together
usda_broiler_inventory_1997_2017 <- rbind(broiler_inventory_2017,
                                    broiler_inventory_2012,
                                    broiler_inventory_2007,
                                    broiler_inventory_2002,
                                    broiler_inventory_1997) 

# nix the unwanted columns
usda_broiler_inventory_1997_2017 <- usda_broiler_inventory_1997_2017 %>%
  select(-contains("end_code")) %>%
  select(-contains("domaincat_desc")) %>%
  select(-contains("load_time")) %>%
  select(-contains("week_ending")) %>%
  select(-contains("sector_desc")) %>%
  select(-contains("begin_code")) %>%
  select(-contains("congr")) %>%
  select(-contains("period")) %>%
  select(-contains("group_desc")) %>%
  select(-contains("country")) %>%
  select(-contains("week")) %>% 
  select(-contains("district")) %>% 
  select(-contains("zip")) %>%
  select(-contains("class")) %>%
  select(-contains("region")) %>% 
  select(-contains("watershed_code")) %>% 
  select(-contains("util")) %>% 
  select(-contains("data")) %>%
  select(-contains("location_desc")) %>%
  select(-contains("cv"))
