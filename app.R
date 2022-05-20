
### Title: Example of an app built with shiny
### Auth: Jaime LLera
### Date: 20/05/22

library(shiny)



## runApp() to load images from www
# Se añade en fluidpage el contenido

# 2 inputs
ui <- fluidPage(
  includeCSS("www/bootstrap.css"),
  
  # Html and style functions
  h1("Test for a Shiny app", class="h1"),
  a(href = "https://github.com/Jaimelan", "My GitHub"),
  
  hr(),  # Horizontal rule
  
  fluidRow(
    # column(4, tags$img(width=250, src = "mage.png")), # embed an image
  # Inputs
    column(4, sliderInput(inputId= "num", 
                          label = "Choose a number", 
                          min=10, max=100, value=10)), # Add a slider input object
  
    column(4, textInput(inputId = "title", label = "Write a title", value = "Random Normal Values")), # Add text input
  ),
  # Encapsulate objects inside a panel
  wellPanel(
    # Action button to switch between two types of output
    actionButton(inputId = "norm", label = "Normal", class="btn-danger"), 
    actionButton(inputId = "unif", label = "Uniform", class="btn-warning"),
    ),
  
  # Reactive outputs
  tabsetPanel(
    # Outputs separated into tabs 
    tabPanel("Histogram", plotOutput("hist")),
    tabPanel("Stat summary", verbatimTextOutput("stats"))
  )
) 

server <- function(input, output) {

  # Reactive values store reactive dependencies that change whenevr a reaction is triggered
  rv <- reactiveValues(data = rnorm(100))
  # When "button" is pressed the rv$data vals will be changed to the distribution
  observeEvent(input$norm, {rv$data <- rnorm(input$num) })
  observeEvent(input$unif, {rv$data <- runif(input$num) })
  
  # Rules for the histogra output
  output$hist <- renderPlot({ 
    title <- "100 random normal values"
    hist(rv$data, main = isolate({input$title}))
    })
  
  output$stats <- renderPrint({
    summary(rv$data)
  })
  
  }

shinyApp(ui = ui, server = server)

runApp()
