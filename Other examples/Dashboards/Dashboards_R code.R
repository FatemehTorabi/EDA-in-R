library(shiny)
library(ggplot2)
library(plotly)

ui <- fluidPage(
  titlePanel("Healthcare Data Dashboard"),
  sidebarLayout(
    sidebarPanel(
      sliderInput("ageRange", "Select Age Range:", min = 40, max = 80, value = c(40, 80))
    ),
    mainPanel(
      plotlyOutput("scatterPlot"),
      plotOutput("barChart")
    )
  )
)

server <- function(input, output) {
  filtered_data <- reactive({
    data[data$Age >= input$ageRange[1] & data$Age <= input$ageRange[2], ]
  })
  
  output$scatterPlot <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = Cholesterol, y = BloodPressure, color = Outcome)) +
      geom_point(size = 3, alpha = 0.7) +
      labs(title = "Cholesterol vs Blood Pressure",
           x = "Cholesterol Level",
           y = "Blood Pressure",
           color = "Health Outcome") +
      theme_minimal()
    ggplotly(p)
  })
  
  output$barChart <- renderPlot({
    ggplot(filtered_data(), aes(x = Outcome, fill = Outcome)) +
      geom_bar() +
      labs(title = "Number of Patients by Health Outcome",
           x = "Health Outcome",
           y = "Count") +
      theme_minimal()
  })
}

shinyApp(ui = ui, server = server)