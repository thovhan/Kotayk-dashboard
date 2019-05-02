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


shapeData <- readOGR("Armenia_Marzes", "Armenia_Marzes")
shapeData <- spTransform(shapeData, CRS("+proj=longlat +datum=WGS84 +no_defs"))


r_colors <- rgb(t(col2rgb(colors()) / 255))
names(r_colors) <- colors()

ui <- fluidPage(
  
  # App title ----
  titlePanel("Cadastre!"),
  
  # Sidebar layout with input and output definitions ----
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(
      leafletOutput("mymap")
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
  
  output$mymap <- renderLeaflet({
    leaflet(shapeData) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.5,
                  opacity = 1.0, fillOpacity = 0.5,
                  #fillColor = ~colorQuantile("YlOrRd", ALAND)(ALAND),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE))
  })
}

shinyApp(ui, server)




