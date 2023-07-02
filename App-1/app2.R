library(shiny)

ui <- fluidPage(
  
  titlePanel("This is my title"),
  
  fluidRow(
    h1("censusVis"),
    sidebarLayout(
      sidebarPanel(
        helpText("Create demographic maps with information from the 2010 US Census."),
        selectInput(
          "var",
          label = "Choose a variable to display",
          choices = c("Percent White", "Percent Black", "Percent Italian", "Percent Asian"),
          selected = "Percent Italian"
        ),
        sliderInput(
          "slider",
          label = "Choose a value",
          min = 0,
          max = 100,
          value = 1,
          step = 1
        )
      ),
      mainPanel()
    )
  )
)

server <- function(input, output) {
  
}

shinyApp(ui = ui, server = server)
