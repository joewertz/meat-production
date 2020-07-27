# import libraries --------------------------------------------------------
library("tidyverse")
library("janitor")
library("readxl")
library("stringr")
library("sf")
library("tigris")
library("leaflet")


# import data -------------------------------------------------------------

cafos_shp <- st_read("C:/data/meat-production/CAFO_Density/CAFOs_per_County.shp") %>% 
  clean_names()


# plot the data -----------------------------------------------------------

pal <- colorBin("Blues", domain = cafos_shp$caf_os, 7)

cafos_shp %>% 
  leaflet() %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(-98.483330, 38.712046, zoom = 4) %>%
  addPolygons(data = cafos_shp,
              fillColor = ~pal(cafos_shp$caf_os),
              fillOpacity = 1, 
              weight = 0.3, 
              smoothFactor = 0.2, 
              stroke = TRUE,
              color = "black",
              popup = ~name) %>%
  addLegend(pal = pal, 
            values = cafos_shp$caf_os, 
            position = "bottomright", 
            title = "CAFOs per county")
