# Load packages ----
library(shiny)
library(httr)
library(jsonlite)

# User interface ----
ui <- fluidPage(
  titlePanel("Flight Information"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Enter the ICAO24 code of the aircraft to retrieve its flight information."),
      textInput("icao24", "ICAO24 code", ""),
      
      dateRangeInput("dates",
                     "Date range",
                     start = "2023-01-01",
                     end = as.character(Sys.Date())),
      
      br(),
      br(),
      
      checkboxInput("positions", "Include aircraft positions",
                    value = FALSE)
    ),
    
    mainPanel(tableOutput("flightTable"))
  )
)

# Server logic
server <- function(input, output) {
  
  flightInfo <- reactive({
    if (isTruthy(input$icao24)) {
      startDateTime <- format(input$dates[1], "%Y-%m-%dT%H:%M:%S")
      endDateTime <- format(input$dates[2], "%Y-%m-%dT%H:%M:%S")
      
      url <- paste0("https://opensky-network.org/api/flights/aircraft?icao24=", input$icao24,
                    "&begin=", startDateTime,
                    "&end=", endDateTime)
      response <- GET(url)
      
      if (http_type(response) == "application/json") {
        content <- content(response, "text")
        
        tryCatch(
          {
            json <- jsonlite::fromJSON(content)
            json
          },
          error = function(e) {
            message("Error parsing JSON response:", e$message)
            NULL
          }
        )
      } else {
        NULL
      }
    } else {
      NULL
    }
  })
  
  
  
  
  output$flightTable <- renderTable({
    flight <- flightInfo()
    
    if (!is.null(flight)) {
      if (input$positions) {
        positions <- lapply(flight$states, function(state) {
          if (!is.na(state$longitude) && !is.na(state$latitude)) {
            c(state$time, state$longitude, state$latitude)
          }
        })
        
        positions <- do.call(rbind, positions)
        colnames(positions) <- c("Time", "Longitude", "Latitude")
        
        positions
      } else {
        flight$states
      }
    } else {
      NULL
    }
  })
}

# Run the app
shinyApp(ui, server)
