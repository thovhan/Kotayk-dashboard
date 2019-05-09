
ui <- fluidPage(
  
  navbarPage( title = "Cadastre",
              
              tabPanel( "Monuments",
                        sidebarPanel(
                          leafletOutput("kotaykMap")
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
