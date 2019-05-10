# Installing the required packages
required.packages = c("sf", "sp", "rgdal", "leaflet", "shiny", "dplyr", "ggplot2", "shinydashboard")
new.packages = required.packages[!(required.packages 
    %in% installed.packages()[, "Package"])]
if (length(new.packages))
  install.packages(new.packages, dependencies = TRUE)

sapply(required.packages, require, character.only = TRUE)

source("ui.R")
source("server.R")

shinyApp(ui, server)


