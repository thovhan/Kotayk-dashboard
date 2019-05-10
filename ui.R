
ui <- fluidPage(
  
  #landmarkTypeChoices = 
  
  navbarPage( title = "Cadastre",
              
              tabPanel( "Landmarks",
                        fluidRow(
                          
                          column(7,
                            htmlOutput("select_monument_type_UI"),
                            leafletOutput("kotaykMap")
                          ),
                          column(5,
                                 shinydashboard::box(width=4, height = 2, plotOutput("kotayk_piechart_by_type"), status="primary"),
                                 shinydashboard::box(width=4, height = 2, plotOutput("kotayk_piechart_by_town"), status="primary")
                          # plotOutput("kotayk_piechart_by_town")
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
