library(shiny)

# Se añade en fluidpage el contenido

# 2 inputs
ui <- fluidPage(
  sliderInput(inputId= "num", label = "Choose a number", min=10, max=100, value=10),
  textInput(inputId = "title", label = "Write a title", value = "Random Normal Values"),
  plotOutput("hist"),
  verbatimTextOutput("stats")
  
) 

server <- function(input, output) {
  
  data <- reactive({
    rnorm(input$num)
  })
  
  
  
  output$hist <- renderPlot({ 
    title <- "100 random normal values"
    hist(data(), main = isolate({input$title}))
    })
  
  output$stats <- renderPrint({
    summary(data())
  })
  
  }

shinyApp(ui = ui, server = server)

