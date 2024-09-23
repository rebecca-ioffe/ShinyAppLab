library(shiny)
library(rsconnect)
#rsconnect::deployApp("/Users/rioffe/practice_wk3/app.R")


# Define UI
ui <- fluidPage(
  
  titlePanel("USArrests Correlation Calculator"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("x_var", "Choose  an X variable:", choices = colnames(USArrests)),
      selectInput("y_var", "Choose a Y variable:", choices = colnames(USArrests)),
      actionButton("calculate", "Calculate Correlation"),
      hr(),
      h4("Correlation Results:"),
      verbatimTextOutput("correlation_output")
    ),
    
    mainPanel(
      plotOutput("scatterplot")
    )
  )
)

# Define server logic
server <- function(input, output) {
  
  # Render scatterplot
  output$scatterplot <- renderPlot({
    plot(USArrests[[input$x_var]], USArrests[[input$y_var]],
         xlab = input$x_var, ylab = input$y_var, main = "Scatterplot")
  })
  
  # Calculate and render correlation coefficient
  output$correlation_output <- renderPrint({
    cor_coef <- cor(USArrests[[input$x_var]], USArrests[[input$y_var]])
    paste("Correlation coefficient:", round(cor_coef, 3))
  })
}

# Run the application
shinyApp(ui = ui, server = server)
