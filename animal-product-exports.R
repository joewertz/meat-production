
# load packages -----------------------------------------------------------

library("tidyverse")
library("janitor")
library("ggplot2")

# import data -------------------------------------------------------------

#data from USA Trade
egg_exports_92_19 <- read_csv("C:/data/meat-production/exports/egg_exports_92_19.csv", skip = 4) %>%
  clean_names()
milk_exports_92_19 <- read_csv("C:/data/meat-production/exports/milk_exports_92_19.csv", skip = 4) %>% 
  clean_names()
poultry_exports_92_19 <- read_csv("C:/data/meat-production/exports/poultry_exports_92_19.csv", skip = 4) %>% 
  clean_names()
swine_exports_92_19 <- read_csv("C:/data/meat-production/exports/swine_exports_92_19.csv", skip = 4) %>% 
  clean_names()


# bind data into one df ---------------------------------------------------

major_animal_product_exports <- rbind(egg_exports_92_19, milk_exports_92_19, poultry_exports_92_19, swine_exports_92_19)

# some light viz ----------------------------------------------------------

egg_exports_92_19 %>%
  ggplot(aes(x = time,
             y = value_us)) +
  geom_line()
