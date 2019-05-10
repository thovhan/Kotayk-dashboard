
ui <- fluidPage(
  
  landmarkTypeChoices = 
  
  navbarPage( title = "Cadastre",
              
              tabPanel( "Landmarks",
                        
                        sidebarPanel(
                          #htmlOutput("select_monument_type_UI"),
                          leafletOutput("kotaykMap")
                        ),
                        mainPanel(
                          plotOutput("kotayk_piechart_by_type"),
                          plotOutput("kotayk_piechart_by_town")
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
