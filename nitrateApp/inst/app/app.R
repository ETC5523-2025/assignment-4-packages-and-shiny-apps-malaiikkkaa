# Loading the packages
library(shiny)
library(ggplot2)

# Loading the data from the package
data("nitrates_small", package = utils::packageName())

# UI

ui <- fluidPage(
  headerPanel("Exploring Nitrate Concentrations by Site (June and July 2019"),
  sidebarPanel(
    selectInput("site", "Select a site",
                choices = unique(nitrates_small$site)),
    dateRangeInput("daterange", "Select a date",
                  start = min(nitrates_small$date),
                  end = max(nitrates_small$date),
                  min = min(nitrates_small$date),
                  max = max(nitrates_small$date),

    ),
    mainPanel(
      plotOutput("nitratePlot")
    )
  )
)

# Server

server <- function(input, output) {

  reactive_data <- reactive({
                      dplyr::filter(
                        nitrates_small,
                            site == input$site,
                            date >= input$daterange[1],
                            date <= input$daterange[2] )
  })

  output$nitratePlot <- renderPlot({
    ggplot(reactive_data(),
           aes(x = date, y = nitrate_mgL, fill = site)) +
              geom_line()+
              geom_point() +
      labs(title = paste("Nitrate Concentrations at", input$site),
           x = "Date",
           y = "Nitrate (mg/L)")
  })
}

# Running the app
shinyApp(ui = ui, server = server)
