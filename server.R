
#Loading required packages
library(shiny)
library(ggvis)

#Server code
shinyServer(
  function(input, output) {
    
    reactive({
      input.x <- input$x
      input.y <- input$y
      #If same variable selected for both X & Y-Axis, Y-Axis is automatically adjusted
      if(input.x==input.y) {
        if(input.x=="Petal.Length") {
          input.y <- "Petal.Width"
        } else if(input.x=="Petal.Width") {
          input.y <- "Petal.Length"
        } else if(input.x=="Sepal.Length") {
          input.y <- "Sepal.Width"
        } else if(input.x=="Sepal.Width") {
          input.y <- "Sepal.Length"
        }
        #Output a message to notify user about 
        output$msg <- renderText({paste("Same variable is selected for both Axis. Variable of Y-Axis is changed to", input.y)})
      }
      else {  
        #Clear/reset the message
        output$msg <- renderText({""})
      }
      
      input.size <- input$size
      input.opacity <- input$opacity
      input.span <- input$span
      
      iris %>%
        ggvis(prop("x", as.name(input.x)), prop("y", as.name(input.y))) %>%
        group_by(Species) %>%
        layer_points(size:=input.size, opacity:=input.opacity, fill=~Species) %>%
        layer_smooths(span=input.span, fill=~Species, se=TRUE)
      
    }) %>% bind_shiny("ggvis", "ggvis_ui")  
  }
)
