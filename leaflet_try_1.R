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


ui <- fluidPage(
  
  # App title ----
  titlePanel("Cadastre!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      leafletOutput("Map")
    ),
    
    # Main panel for displaying outputs ----
    mainPanel(
      
      # Output: Histogram ----
      plotOutput(outputId = "distPlot")
      
    )
  )

)

server <- function(input, output, session) {
  
  
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  
  shapeData <- readOGR("Armenia_Marzes", "Armenia_Marzes")
  shapeData <- spTransform(shapeData, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  
  
  output$Map <- renderLeaflet({
    leaflet(shapeData) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.5, layerId = shapeData$MarzID,
                  #fillColor = ~colorQuantile("YlOrRd", ALAND)(ALAND),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE))
  })
  
  observeEvent(input$Map_shape_click, { # update the location selectInput on map clicks
    p <- input$Map_shape_click
    print(p$id) ## If of the marz
  })
}

shinyApp(ui, server)




