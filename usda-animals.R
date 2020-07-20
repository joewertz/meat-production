# load packages -----------------------------------------------------------
library("tidyverse")
library("janitor")
library("tidyUSDA")

# USDA key ----------------------------------------------------------------
# Suggest keeping keys outside the project when possible.
# R way to do this seems to be to store in the Keyring like:
# key <- keyring::key_get("tidyusda")
key <- "402BA5AF-8117-3EBC-89F8-837F070C47C1"

# years -------------------------------------------------------------------

years <- c("1997", "2002", "2007", "2012", "2017")

# usda data function ------------------------------------------------------

get_usda_data <- function(data_item, data_year) {
  tidyUSDA::getQuickstat(
    domain = "TOTAL",
    key = key,
    program = "CENSUS",
    data_item = data_item, # data_item argument, e.g. "HOGS - INVENTORY"
    geographic_level = "COUNTY",
    year = data_year, # data_year argument
    geometry = TRUE
  )
}

# get and clean function --------------------------------------------------

get_and_clean_usda_data <- function(data_item, data_years) {
  data_years %>%
    map_dfr(function(year)
      get_usda_data(data_item, year)) %>%
    clean_names() %>%
    select(
      -contains("end_code"),
      -contains("domaincat_desc"),
      -contains("load_time"),
      -contains("week_ending"),
      -contains("sector_desc"),
      -contains("begin_code"),
      -contains("congr"),
      -contains("period"),
      -contains("group_desc"),
      -contains("country"),
      -contains("week"),
      -contains("district"),
      -contains("zip"),
      -contains("class"),
      -contains("region"),
      -contains("watershed_code"),
      -contains("util"),
      -contains("data"),
      -contains("location_desc"),
      -contains("cv")
    )
}

# egg layer data ----------------------------------------------------------

usda_layer_inventory_1997_2017 <-
  get_and_clean_usda_data("CHICKENS, LAYERS - INVENTORY", years)

# cattle data -------------------------------------------------------------

usda_cattle_inventory_1997_2017 <-
  get_and_clean_usda_data("CATTLE, COWS - INVENTORY", years)

# hog data ----------------------------------------------------------------

usda_hog_inventory_1997_2017 <-
  get_and_clean_usda_data("HOGS - INVENTORY", years)

# chicken broiler data ----------------------------------------------------

usda_broiler_inventory_1997_2017 <-
  get_and_clean_usda_data("CHICKENS, BROILERS - INVENTORY", years)
