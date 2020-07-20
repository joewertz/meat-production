# load packages -----------------------------------------------------------

library("dplyr")
library("tidyverse")
library("readxl")
library("janitor")


# download data -----------------------------------------------------------

download.file(url = "https://www.ers.usda.gov/webdocs/DataFiles/51875/RedMeatPoultry_Prod.xlsx?v=3560.4",
               destfile = "RedMeatPoultry.xlsx")

# import data -------------------------------------------------------------

hog_operations_07_12_17 <- read.csv("hog_inventory_07_12_17.csv") %>% 
  clean_names()
hog_operations_97_02 <- read.csv("hog_inventory_97_02.csv") %>% 
  clean_names()

red_meat_poultry <- read_excel(path = "RedMeatPoultry.xlsx",
                               sheet = "RedMeatPoultry_Prod-Full") %>%
  clean_names()

# combine data frames -----------------------------------------------------

hog_operations97_17 <- rbind(hog_operations_97_02, hog_operations_07_12_17)


# tidy data ---------------------------------------------------------------

# nix the unwanted columns
hog_operations97_17 <- hog_operations97_17 %>% 
  select(-contains("program")) %>%
  select(-contains("period")) %>%
  select(-contains("week")) %>% 
  select(-contains("district")) %>% 
  select(-contains("zip")) %>% 
  select(-contains("region")) %>% 
  select(-contains("watershed")) %>% 
  select(-contains("commodity")) %>% 
  select(-contains("data")) %>% 
  select(-contains("cv")) %>% 
# change values to numeric and force in those NAs  
  mutate(value = as.numeric(value)) %>% 
  filter(domain == "TOTAL") %>% 
  filter(state == "NORTH CAROLINA")


# add leading zeroes to ansi codes
  

