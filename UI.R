library(shiny)
library(tidyverse)
shinyUI(
  fluidPage(
    br(), titlePanel(title = 'Trends in Demographics and Income'),
    p("Explore the difference between people who earn less than 50K and more than 50K. You can filter the data by country, then explore various demographic information."),
    fluidRow(
      column(12, 
             wellPanel(selectInput("country", "Native Country", list('United States', 'Canada', 'Mexico', 'Germany', 'Philippines'), selected = NULL)) 
      )
    ),
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a continuous variable and graph type (histogram or boxplot) to view on the right."),
               radioButtons("continuous_variable", "Age/Hours per week", choices = c("age", "hours_per_week")), 
               radioButtons("graph_type", "Histogram/Box Plot", choices = c("histogram", "boxplot")) 
             )
      ),
      column(9, plotOutput("p1")) 
    ),
    fluidRow(
      column(3, 
             wellPanel(
               p("Select a categorical variable to view bar chart on the right. Use the check box to view a stacked bar chart to combine the income levels into one graph. "),
               radioButtons("categorical_variable", "Select Variable", choices = c("education", "workclass", "sex")), 
               checkboxInput("is_stacked", "Stack bars?", value = TRUE, width = NULL) 
             )
      ),
      column(9, plotOutput("p2")) 
    )
  )
)
