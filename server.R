
server <- function(input, output, session) {
  # Server for rendering the monument data for a state
  source("kotayk_server.R")
  kotayk_server(input, output, session)
  
  ## Armenia
  points <- eventReactive(input$recalc, {
    cbind(rnorm(40) * 2 + 13, rnorm(40) + 48)
  }, ignoreNULL = FALSE)
  
  shapeData <- readOGR("Armenia_Marzes", "Armenia_Marzes")
  shapeData <- spTransform(shapeData, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  
  output$Map <- renderLeaflet({
    leaflet(shapeData) %>%
      addPolygons(color = "#444444", weight = 1, smoothFactor = 0.05,
                  opacity = 1.0, fillOpacity = 0.5, layerId = shapeData$MarzID,
                  #fillColor = ~colorQuantile("YlOrRd", ALAND)(ALAND),
                  highlightOptions = highlightOptions(color = "white", weight = 2,
                                                      bringToFront = TRUE))
  })
  
  observeEvent(input$Map_shape_click, { # update the location selectInput on map clicks
    p <- input$Map_shape_click
    output$cityControls <- renderText(p$id)
    print(p$id)
  })  
}
