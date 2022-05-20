library(shiny)

# Se añade en fluidpage el contenido

# 2 inputs
ui <- fluidPage(
  # Html and style functions
  h1("Test for a Shiny app"),
  a(href = "https://github.com/Jaimelan", "My GitHub"),
  
  hr(),
  
 

  fluidRow(
  # Inputs
    column(6, sliderInput(inputId= "num", label = "Choose a number", min=10, max=100, value=10)),
    column(6, textInput(inputId = "title", label = "Write a title", value = "Random Normal Values")),
  ),
  wellPanel(
    actionButton(inputId = "norm", label = "Normal"),
    actionButton(inputId = "unif", label = "Uniform"),
    ),
  
  # Reactive outputs
  tabsetPanel(
    tabPanel("Histogram", plotOutput("hist")),
    tabPanel("Stat summary", verbatimTextOutput("stats"))
  )
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

