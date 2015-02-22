
#Loading required packages
library(shiny)

shinyUI(
  navbarPage("Simple IRIS Dataset Explorer",
    tabPanel("Plot",
      pageWithSidebar(
        "",
        sidebarPanel(  
          selectInput("x", "Choose Variable for X-Axis:", choices=names(iris[, -5]), selected="Sepal.Length" ),
          selectInput("y", "Choose Variable for Y-Axis:", choices=names(iris[, -5]), selected="Sepal.Width" ),
          strong("Choose Plot Settings"),
          sliderInput("size", "Poin Size", 10, 1000, value = 100),
          sliderInput('opacity', "Point Opacity", 0, 1, value = 0.5),
          sliderInput('span', "Span", 0.5, 1, value = 0.75)
        ),                  
        mainPanel(
          #To display message from server, if any
          div(textOutput("msg"), style="color:red;height:30px;padding-left:30px"),
          uiOutput("ggvis_ui"),
          ggvisOutput("ggvis")
        )
      )
    ),
    tabPanel("Help",
      mainPanel(
        includeMarkdown("help.md")
      )
    )
  )
)