# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)

shinyUI(pageWithSidebar(   
   headerPanel("Khan dash board v1"),
   sidebarPanel(
         sliderInput("no_days", "Past # days",
                            min = 0, max = 90, value = 7),
         tags$pre("\t"),
         textInput("text", label = h3("Chat Room"), value = "",placeholder="Start chatting.....")
         
    ),
    # Create a spot for the barplot
    mainPanel(
      
      
      tabsetPanel(
        
        
        tabPanel("# badges",
                 plotOutput("badgeplot"),
                 textOutput("BadgeText")
                 ),
        
        tabPanel("# posts",
                 plotOutput("postplot"),
                 textOutput("PostText")
                 ),
        
        tabPanel("Project Tracker",
                 plotOutput("proj_tracker"),
                 textOutput("ProjectText")
                 )
        
        
      )
      
      
      
    ) # main panel
    
))
