library(shiny)
library(tidyverse)

adult <- read_csv("adult.csv")
names(adult) <- tolower(names(adult))
shinyServer(function(input, output) {
  
  df_country <- reactive({
    adult %>% filter(native_country == input$country)
  })
  output$p1 <- renderPlot({
    if (input$graph_type == "histogram") {
      ggplot(data = df_country(), aes_string(x = input$continuous_variable)) +
        geom_histogram() + 
        labs(title = "Population Distribution", y = "Number of people") +
        facet_wrap(.~prediction_factor) 
    }
    else {
      ggplot(data = df_country(), aes_string(y = input$continuous_variable)) +
        geom_boxplot() + 
        coord_flip() +  
        labs(title = "Population Distribution") + 
        facet_wrap(.~prediction_factor)   
    }
  })
  output$p2 <- renderPlot({
    p <- ggplot(data = df_country(), aes_string(x = input$categorical_variable)) +
      labs(title = "Population Distribution by categorical variables", y = "Number of People") +
      theme(axis.text.x = element_text(angle = 45), legend.position = "bottom")  
    if (input$is_stacked) {
      p + geom_bar(fill = factor(adult$prediction))
    }
    else{
      p + 
        geom_bar(fill = input$categorical_variable) + 
        facet_wrap(.~prediction_factor) 
    }
  })
})
