
ui <- fluidPage(title = "Cadastre Landmark Explorer",
  tabPanel( "Landmarks",
    div(class="outer",
      tags$head(
        includeCSS("styles.css"),
        includeScript("gomap.js")
      ),
      leafletOutput("kotaykMap", width="100%", height="100%"),
      absolutePanel(id = "controls", class = "panel panel-default", 
          fixed = TRUE, draggable = TRUE, top = 20, left = "auto", 
          right = 20, bottom = "auto", width = 330, height = "auto",
        h2("Landmark explorer"),
        htmlOutput("select_monument_type_UI"),
        plotOutput("kotayk_piechart_by_type", height = 250)
      )
    )  
  )
)
