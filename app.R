library(shiny)

# Se añade en fluidpage el contenido

# 2 inputs
ui <- fluidPage(
  sliderInput(inputId= "num", label = "Choose a number", min=10, max=100, value=10),
  textInput(inputId = "title", label = "Write a title", value = "Random Normal Values"),
  
  actionButton(inputId = "norm", label = "Normal"),
  actionButton(inputId = "unif", label = "Uniform"),
  
  plotOutput("hist"),
  verbatimTextOutput("stats")
  
) 

server <- function(input, output) {

  
  rv <- reactiveValues(data = rnorm(100))
  
  observeEvent(input$norm, {rv$data <- rnorm(input$num) })
  observeEvent(input$unif, {rv$data <- runif(input$num) })
  
  output$hist <- renderPlot({ 
    title <- "100 random normal values"
    hist(rv$data, main = isolate({input$title}))
    })
  
  output$stats <- renderPrint({
    summary(rv$data)
  })
  
  }

shinyApp(ui = ui, server = server)

