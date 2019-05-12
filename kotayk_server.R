kotayk_server <- function(input, output, session) {
  ## Kotayk tab
  kotaykMap <- readOGR("Kotayk_Province", "kotayk")
  kotaykMap <- spTransform(kotaykMap, CRS("+proj=longlat +datum=WGS84 +no_defs"))
  
  kotaykData <- read.csv("kotayq.csv")

  source("monument_mapping.R")

  output$select_monument_type_UI <- renderUI({ 
    si <- selectInput("monTypes", "Select monument type",  mapping$Name, 
      selectize = TRUE, multiple=TRUE)
  })
  
  output$kotaykMap <- renderLeaflet({
    l <- leaflet(kotaykMap, options = leafletOptions(minZoom = 10)) %>%
            addTiles() %>%
            addPolygons(weight = 1, smoothFactor = 0.05,
              opacity = 1.0, fillOpacity = 0.05,
              highlightOptions = highlightOptions(
                color = "white", weight = 2, bringToFront = TRUE)
              )

    monumentCodes <- mapping[mapping$Name %in% input$monTypes, ]$Code

    filteredData <-kotaykData[kotaykData$type %in% monumentCodes, ]

    if (nrow(filteredData) > 0) {
      kotaykLat <- filteredData$Lat %>%
        sub(':', 'd', .) %>%
        sub(':', '\'', .) %>%
        char2dms %>%
        as.numeric

      kotaykLon <- filteredData$Lon %>%
        sub(':', 'd', .) %>%
        sub(':', '\'', .) %>%
        char2dms %>%
        as.numeric

      l <- l %>%
        addMarkers(lng = ~kotaykLon, lat = ~kotaykLat,
          clusterOptions = markerClusterOptions(),
          label = mapply(
            function(name, town, code, type) {
              HTML(sprintf(
                "<b>Name: </b> %s </br> 
                <b>Town: </b> %s </br>
                <b>Code: </b> %s </br>
                <b>Type: </b> %s", 
                name, town, code, type
              ))
            },
            filteredData$town_name_armenian, filteredData$town_name_2, 
            filteredData$code, 
            mapping[mapping$Code == filteredData$type, ]$Name,
            SIMPLIFY = F
          ),
          labelOptions = lapply(1:nrow(filteredData), function(x) {
            labelOptions(direction = 'auto')
          })
        )
    }
      l
  })
  
  output$kotayk_piechart_by_type <- renderPlot({
    kotaykData %>% group_by(type) %>%
      summarise(count = n()) %>%  top_n(10) %>%
      ggplot(aes(x = "type", y = count, fill = type)) +
      geom_bar(width = 1, stat='identity')
  })
  
  output$kotayk_piechart_by_town <-renderPlot({
    kotaykData %>% group_by(town_name_eng) %>%
      summarise(count=n()) %>%  top_n(10) %>%
      ggplot(aes(x = "", y = count, fill = town_name_eng)) +
      geom_bar(width = 1, stat='identity') +
      coord_polar("y", start=0)
  })

}