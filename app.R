library(shiny)

# Se añade en fluidpage el contenido
ui <- fluidPage(
  sliderInput(inputId= "num", label = "Choose a number", min=10, max=100, value=10),
  plotOutput("hist")
  
                
) 

server <- function(input, output) {
  output$hist <- renderPlot({ 
    title <- "100 random normal values"
    hist(rnorm(input$num), main = title)
    })
  
  }

shinyApp(ui = ui, server = server)
