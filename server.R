library(shiny)
library(UsingR)
library(sqldf)

Titan_Stat <- read.csv("Titanic.csv", header = TRUE, sep =",")

shinyServer(
  function(input,output,session) {
    output$Class <- renderText({input$Class})
      output$Age <- renderText({input$Age})
      output$Sex <- renderText({input$Sex})

      
      output$table <- renderDataTable({
      titan_group <- sqldf("select Class, Sex, Age, sum(Freq) TOT 
                              from Titan_Stat
                             group by Class, Sex, Age")
        
      titan_final <- sqldf("select ts.*, TOT 
                              from Titan_Stat ts, titan_group tg
                             where ts.Class = tg.Class and
                                   ts.Sex = tg.Sex and 
                                   ts.Age = tg.Age")
      
            titan <- sqldf("select tf.*, (cast(Freq as real) / TOT) PROB 
                                 from titan_final tf")
        
            x <-  titan[titan$Class == input$Class &
                        titan$Age == input$Age &
                        titan$Sex == input$Sex,]
        })
    
    
      output$myPlot1 <- renderPlot({   
        ggplot(data = Titan_Stat, aes(x = Age, y = Freq)) + 
           facet_grid(. ~ Survived) +
           geom_point() +
           stat_summary(fun.y=sum, geom="bar")})
    
      output$myPlot2 <- renderPlot({
        ggplot(data = Titan_Stat, aes(x = Sex, y = Freq)) + 
           facet_grid(. ~ Survived) +
           geom_point() +
           stat_summary(fun.y=sum, geom="bar")})
    
      output$myPlot3 <- renderPlot({
        ggplot(data = Titan_Stat, aes(x = Class, y = Freq)) + 
           facet_grid(. ~ Survived) +
           geom_point() +
           stat_summary(fun.y=sum, geom="bar")})
    })