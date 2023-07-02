#Giovanni De Franceschi
#R Shiny practice

library(shiny)

ui <- fluidPage(
  titlePanel("Hello WORLD!"),
  
  sidebarLayout(
    sidebarPanel(
      sliderInput(
        inputId = "buckets",
        label = "Number of buckets",
        min = 5,
        max = 100,
        value = 50
      )
    ),
    
    mainPanel(
      plotOutput(
        outputId = "distPlot"
      )
    )
  )
)

server <- function(input, output) {
  output$distPlot <- renderPlot({
    x <- faithful$waiting
    bins <- seq(min(x), max(x), length.out = input$buckets + 1)
    
    hist(
      x,
      breaks = bins,
      col = "#505050",
      border = "orange",
      xlab = "Waiting time to next event (minutes)",
      main = "Histogram of waiting times"
    )
  })
}

shinyApp(ui = ui, server = server)
