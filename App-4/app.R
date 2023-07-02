library(shiny)
library(maps)
library(mapproj)

# Load data
counties <- readRDS("data/counties.rds")

# Source helper functions
source("helpers.R")

# User interface
ui <- fluidPage(
  titlePanel("censusVis"),  # Title of the application
  
  sidebarLayout(
    sidebarPanel(
      helpText("Create demographic maps with 
        information from the 2010 US Census."),  # Help text
      
      selectInput("var", 
                  label = "Choose a variable to display",  # Select input for choosing a variable
                  choices = c("Percent White", "Percent Black",
                              "Percent Hispanic", "Percent Asian"),  # Available variable choices
                  selected = "Percent White"),  # Default selected variable
      
      sliderInput("range", 
                  label = "Range of interest:",  # Slider input for selecting a range
                  min = 0, max = 100, value = c(0, 100))  # Range limits and default values
    ),
    
    mainPanel(plotOutput("map"))  # Output plot panel
  )
)

# Server logic
server <- function(input, output) {
  output$map <- renderPlot({
    # Retrieve data based on the selected variable
    data <- switch(input$var, 
                   "Percent White" = counties$white,
                   "Percent Black" = counties$black,
                   "Percent Hispanic" = counties$hispanic,
                   "Percent Asian" = counties$asian)
    
    # Determine color based on the selected variable
    color <- switch(input$var, 
                    "Percent White" = "darkgreen",
                    "Percent Black" = "black",
                    "Percent Hispanic" = "darkorange",
                    "Percent Asian" = "darkviolet")
    
    # Determine legend title based on the selected variable
    legend <- switch(input$var, 
                     "Percent White" = "% White",
                     "Percent Black" = "% Black",
                     "Percent Hispanic" = "% Hispanic",
                     "Percent Asian" = "% Asian")
    
    # Generate the plot using the percent_map function from the helpers.R file
    percent_map(data, color, legend, input$range[1], input$range[2])
  })
}

# Run the Shiny app
shinyApp(ui, server)
