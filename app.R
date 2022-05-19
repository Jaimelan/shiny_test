library(shiny)

# Se añade en fluidpage el contenido

# 2 inputs
ui <- fluidPage(
  # Html and style functions
  tags$h1("Test for a Shiny app"),
  tags$a(href = "https://github.com/Jaimelan", "My GitHub"),
  
  tags$hr(),
  # Inputs
  sliderInput(inputId= "num", label = "Choose a number", min=10, max=100, value=10),
  textInput(inputId = "title", label = "Write a title", value = "Random Normal Values"),
  
  actionButton(inputId = "norm", label = "Normal"),
  actionButton(inputId = "unif", label = "Uniform"),
    
  
  # Reactive outputs
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

