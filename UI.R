library(shiny)
library(ggplot2)

shinyUI(pageWithSidebar(
  headerPanel("Titanic Survival Liklihood"),
  sidebarPanel(
    radioButtons("Class", "In what class would you travel?",
                 c("First" = "1st","Second" = "2nd",
                   "Third" = "3rd","Crew" = "Crew")),
    
    radioButtons(inputId="Age", label="What is your age category?", 
                 c("Child" = "Child","Adult" = "Adult")),
    
    radioButtons(inputId="Sex", label="What is your sex?", 
                 c("Male" = "Male","Female" = "Female")),
    submitButton('Check Probability...')
    ),
  mainPanel(
    

      p(h3('Please look at the PROB column in the below table to 
        see your chances to survive or die (Survived Column) if you were 
           on the Titanic')),
      dataTableOutput(outputId="table"),
      p(h3('Please please find the overall statistics of surviving the Titanic
           accident broken down by Age, Sex and Class')),
      plotOutput('myPlot1'),
      plotOutput('myPlot2'),
      plotOutput('myPlot3')
  )
))

