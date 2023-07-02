library(shiny)

ui <- fluidPage(
  titlePanel("My Shiny App"),
  sidebarLayout(
    sidebarPanel(),
    mainPanel(
      p("p creates a paragraph of text."),
      p("A new p() command starts a new paragraph. Supply a style attribute to change the format of the entire paragraph.", style = "font-family: 'times'; font-size: 16pt;"),
      strong("strong() makes bold text."),
      em("em() creates italicized (i.e., emphasized) text."),
      br(),
      code("code displays your text similar to computer code"),
      div("div creates segments of text with a similar style. This division of text is all blue because I passed the argument 'style = color:blue' to div", style = "color: blue"),
      br(),
      p(
        "span does the same thing as div, but it works with",
        span("groups of words", style = "color: blue"),
        "that appear inside a paragraph."
      ),
      img(src = "my_image.jpg", height = 372, width = 272),
      actionButton("myBtn", label = "Action"),
      selectInput(
        inputId = "mySelect",
        label = "drop-down menu",
        choices = c("Option 1", "Option 2", "Option 3"),
        selected = "Option 1"
      ),
      fluidRow(
        
        column(3,
               h3("Buttons"),
               actionButton("action", "Action"),
               br(),
               br(), 
               submitButton("Submit")),
        
        column(3,
               h3("Single checkbox"),
               checkboxInput("checkbox", "Choice A", value = TRUE)),
        
        column(3, 
               checkboxGroupInput("checkGroup", 
                                  h3("Checkbox group"), 
                                  choices = list("Choice 1" = 1, 
                                                 "Choice 2" = 2, 
                                                 "Choice 3" = 3),
                                  selected = 1)),
        
        column(3, 
               dateInput("date", 
                         h3("Date input"), 
                         value = "2014-01-01"))   
      ),
      
      fluidRow(
        
        column(3,
               dateRangeInput("dates", h3("Date range"))),
        
        column(3,
               fileInput("file", h3("File input"))),
        
        column(3, 
               h3("Help text"),
               helpText("Note: help text isn't a true widget,", 
                        "but it provides an easy way to add text to",
                        "accompany other widgets.")),
        
        column(3, 
               numericInput("num", 
                            h3("Numeric input"), 
                            value = 1))   
      ),
      
      fluidRow(
        
        column(3,
               radioButtons("radio", h3("Radio buttons"),
                            choices = list("Choice 1" = 1, "Choice 2" = 2,
                                           "Choice 3" = 3),selected = 1)),
        
        column(3,
               selectInput("select", h3("Select box"), 
                           choices = list("Choice 1" = 1, "Choice 2" = 2,
                                          "Choice 3" = 3), selected = 1)),
        
        column(3, 
               sliderInput("slider1", h3("Sliders"),
                           min = 0, max = 100, value = 50),
               sliderInput("slider2", "",
                           min = 0, max = 100, value = c(25, 75))
        ),
        
        column(3, 
               textInput("text", h3("Text input"), 
                         value = "Enter text..."))   
      )
    )
  )
)

server <- function(input, output) {
  
}

shinyApp(ui = ui, server = server)
