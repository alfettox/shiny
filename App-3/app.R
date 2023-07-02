#REACTIVE OUTPUT
# Load the shiny library
library(shiny)

# Define the UI (User Interface)
ui <- fluidPage(
  titlePanel("censusVis"),  # Title of the application
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with information from 2010 US Census."),  # Text providing instructions
      
      selectInput("var",  # Input for selecting a variable to display
                  label = "Select",
                  choices = c("Percent White", "Percent Black", "Percent Hispanic", "Percent Asian"),
                  selected = "Percent White"
      ),
      
      sliderInput("range",  # Input for selecting a range of interest
                  label = "Range of interest:",
                  min = 0,
                  max = 100,
                  value = c(50, 70)
      )
    ),
    
    mainPanel(
      textOutput("selected_var"),  # Output for displaying the selected variable and range
      textOutput("min_max")  # Output for displaying the minimum and maximum values of the range
    )
  )
)

# Define the server logic
server <- function(input, output) {
  
  output$selected_var <- renderText({  # Render the selected variable and range as text
    paste("Selected:", input$var, input$range[1], "to", input$range[2])
  })
}

# Run the shiny app
shinyApp(ui, server)
