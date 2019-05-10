kotayk_server <- function(input, output, session) {
  
  ## Kotayk tab
  kotaykMap <- readOGR("Kotayk_Province", "kotayk")
  kotaykMap <- spTransform(kotaykMap, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  
  kotaykData <- read.csv("kotayq.csv")
  kotaykLat <- kotaykData$Lat
  kotaykLon <- kotaykData$Lon
  head(kotaykLat)
  
  kotaykLat <- kotaykLat %>%
    sub(':', 'd', .) %>%
    sub(':', '\'', .) %>%
    char2dms %>%
    as.numeric
  
  kotaykLon <-kotaykLon %>%
    sub(':', 'd', .) %>%
    sub(':', '\'', .) %>%
    char2dms %>%
    as.numeric
  
  #output$select_monument_type_UI <- renderUI({ 
  #  
  #  monumentTypesData <- kotaykData %>% group_by(type)
  #  
  #  si <- selectInput("select_monument_type", "Select your choice",  monumentTypesData)
  #  si
  #})
  
  output$kotaykMap <- renderLeaflet({
    # Use leaflet() here, and only include aspects of the map that
    # won't need to change dynamically (at least, not unless the
    # entire map is being torn down and recreated.)mess
    leaflet(kotaykMap) %>% addTiles() %>% 
      addMarkers(lng = ~kotaykLon, lat = ~kotaykLat, clusterOptions = markerClusterOptions()) %>%
      addPolygons(weight = 1, smoothFactor = 0.05,
                  opacity = 1.0 , fillOpacity = 0.05,
                  highlightOptions = highlightOptions(color = "white", weight = 2, bringToFront = TRUE))
  })
  
  output$kotayk_piechart_by_type <-renderPlot({
    
    #groupTypeData <- kotaykData %>%group_by(type) %>% summarise(count = n())
    
    #pie(groupTypeData$count, groupTypeData$type, col = rainbow(6))
    
    p <- kotaykData %>%group_by(type) %>%
      summarise(count=n()) %>%  top_n(10) %>%
      ggplot(aes(x =type, y = count, fill = type)) +
      geom_bar(width = 1, stat='identity') +
      coord_polar("y", start=0)    
    p
  })
  
  output$kotayk_piechart_by_town <-renderPlot({
    
    p <- kotaykData %>% group_by(town_name_eng) %>%
      summarise(count=n()) %>%  top_n(10) %>%
      ggplot(aes(x = "", y = count, fill = town_name_eng)) +
      geom_bar(width = 1, stat='identity') +
      coord_polar("y", start=0)    
    p
  })

}