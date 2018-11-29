#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(plotluck)
# Define server logic required to draw a histogram
shinyServer(function(input, output,session) {
   
  output$distPlot <- renderPlot({
    
    ##the next lines are used to just read the file in
    inFile <- input$UploadedFile
    print(inFile)
    if (is.null(inFile))
      return(NULL)
    DATA <<- read.csv(inFile$datapath)   

    
    #this function lets you rerun this 
    if(input$Response=="" & is.null(input$Explanatory) )    
{     
      print("is na")
      updateSelectInput(session,"Response",choices = c(".",names(DATA)))
    updateSelectInput(session,"Explanatory",choices = c(1,names(DATA)))
    }   
    plotluck(DATA,.~1)
    
    if(!is.na(input$Response) & !is.na(input$Explanatory) & length(input$Explanatory) < 3)
    {
    FORMULA = formula(paste0(input$Response," ~ ", paste0(input$Explanatory,collapse=" + ")))
      plotluck(DATA,FORMULA)
      
    }

})
  
  
  
  
  
})
