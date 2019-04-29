# Installing the required packages
required.packages = c("sf", "sp", "rgdal", "leaflet")
new.packages = required.packages[!(required.packages %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages)

library(sf)
library(sp)
library(rgdal)
library(leaflet)


shapeData <- readOGR("Armenia_Marzes", "Armenia_Marzes")
shapeData <- spTransform(shapeData, CRS("+proj=longlat +datum=WGS84 +no_defs"))

leaflet(shapeData) %>%
  addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
              opacity = 1.0, fillOpacity = 0.5,
              #fillColor = ~colorQuantile("YlOrRd", ALAND)(ALAND),
              highlightOptions = highlightOptions(color = "white", weight = 2,
                                                  bringToFront = TRUE))
