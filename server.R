

server <- function(input, output, session) {
  
  ## Kotayk tab
  kotaykData <- readOGR("Kotayk_Province", "kotayk")
  kotaykData <- spTransform(kotaykData, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  
  output$kotaykMap <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated).
    leaflet(kotaykData) %>% addTiles() %>% 
      addPolygons(weight = 1, smoothFactor = 0.05,
                  opacity = 1.0, fillOpacity = 0.05,, 
                  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE))
  })
  
  
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
    print(p$id) ## Id of the marz
    tmp <- c(tmp, p$id)
    print(tmp)
  })
  
}
