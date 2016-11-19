# Rely on the 'WorldPhones' dataset in the datasets
# package (which generally comes preloaded).
library(datasets)
library(ggplot2)
# Define a server for the Shiny app
function(input, output) {
  
  dummy_data <-as.data.frame(matrix(0, ncol = 2, nrow = 5))
  dummy_data$V1 <- as.Date(c("05/10/2016", "06/10/2016", "07/10/2016", "08/10/2016","09/10/2016"),"%d/%m/%Y")
  dummy_data$V2 <- c(3,3,1,5,4)
  dummy_data$V3 <- c(1,7,3,2,1)
  
  # load data
  wd.datapath = paste0(getwd())
  setwd(wd.datapath)
  
  d.in <- as.data.frame(readRDS("data/sample_data.rds"))
  d.in$Dates <- as.Date(d.in$Dates, format = "%m/%d/%Y")
  d.in <- d.in[rev(order(d.in$Dates)),]
  
  output$BadgeText <- renderText({ 
    paste("Track your learning progress in the past",input$no_days,"day(s)")
  })
  
  output$PostText <- renderText({ 
    paste("Number of shares in the past",input$no_days,"day(s)")
  })
  
  output$ProjectText <- renderText({ 
    paste("Project progress in the past",input$no_days,"day(s)")
  })
  
  # Fill in the spot we created for a plot
  output$badgeplot <- renderPlot({
    
    # Render a line chart
    # qplot(Dates, Number_badges, data=d.in[1:10,], geom="line")
    
    ggplot(d.in[1:input$no_days,], aes(Dates, Number_badges),colours='blue') +
      geom_point() +
      geom_smooth() +
      labs(x = "Dates", 
           y = "Number of badges"
           )
    
  })
  output$postplot <- renderPlot({
    
    # Render a line chart
    ggplot(d.in[1:input$no_days,], aes(Dates, Number_posts),colours='blue') +
      geom_point() +
      geom_smooth() +
      labs(x = "Dates", 
           y = "Number of posts"
      )
  })
  
  output$proj_tracker <- renderPlot({
    
    # Render a line chart
    ggplot(d.in[1:input$no_days,], aes(Dates, Project_Pct),colours='blue') +
      geom_point() +
      geom_line() +
      labs(x = "Dates", 
           y = "Project complete %"
      )
  })
  
}