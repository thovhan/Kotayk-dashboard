
ui <- fluidPage(
  
  
  navbarPage( title = "Cadastre",
              
              tabPanel( "Landmarks",

                      div(class="outer",

                            tags$head(
                              # Include our custom CSS
                              includeCSS("styles.css"),
                              includeScript("gomap.js")
                            ),

                            # If not using custom CSS, set height of leafletOutput to a number instead of percent
                            leafletOutput("kotaykMap", width="100%", height="100%"),

                            # Shiny versions prior to 0.11 should use class = "modal" instead.
                            absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE,
                              draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto",
                              width = 330, height = "auto",

                              h2("Landmark explorer"),

                              htmlOutput("select_monument_type_UI"),

                              plotOutput("kotayk_piechart_by_type", height = 250)
                            ),

                            tags$div(id="cite",
                              'Data compiled for ', tags$em('Coming Apart: The State of White America, 1960–2010'), ' by Charles Murray (Crown Forum, 2012).'
                            )
                          )                     
                        
                        
              ), # tablPanel - Kotayk
              
              
              tabPanel( "Real Estate",
                        
                        # Sidebar layout with input and output definitions ----
                        sidebarLayout(
                          
                          # Sidebar panel for inputs ----
                          sidebarPanel(
                            leafletOutput("Map")
                          ),
                          
                          # Main panel for displaying outputs ----
                          mainPanel(
                            
                            textOutput("selected_ids")
                            
                          ) # mainpanel
                        )
              ) # tablPanel - Armenia
              
  ) # navbarPage
)
