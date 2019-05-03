# Installing the required packages
required.packages = c("sf", "sp", "rgdal", "leaflet", "shiny")
new.packages = required.packages[!(required.packages %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages)

library(sf)
library(sp)
library(rgdal)
library(leaflet)
library(shiny)

source("ui.R")

source("server.R")

shinyApp(ui, server)




