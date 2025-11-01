# Loading the packages
library(shiny)
library(ggplot2)

# Loading the data from the package
data("nitrates_small", package = utils::packageName())

# Mapping site codes
site_map <- c(
  "ARIK" = "Arikaree River",
  "CARI" = "Caribou Creek",
  "LEWI" = "Lewis Run"
)

# UI
ui <- fluidPage(
  titlePanel("Exploring Nitrate Concentrations by Site (June and July 2019)"),
  sidebarLayout(
    sidebarPanel(
      checkboxGroupInput(
      inputId = "site",
      label = "Select site(s)",
      choices = setNames(names(site_map), unname(site_map)),
      selected = names(site_map)
    ),
    dateRangeInput(
      inputId = "daterange",
      label = "Select a date range",
      start = min(nitrates_small$date),
      end = max(nitrates_small$date),
      min = min(nitrates_small$date),
      max = max(nitrates_small$date))

    ),
    mainPanel(
      plotOutput("nitratePlot")
    )
  )
)


# Server

server <- function(input, output) {

  reactive_data <- reactive({
    req(length(input$site) >0)

      nitrates_small |>
        dplyr::filter(
          site %in% input$site,
          date >= input$daterange[1],
          date <= input$daterange[2] )
  })

  output$nitratePlot <- renderPlot({
    df <- reactive_data()
    req(nrow(df)>0)

    ggplot(df,
           aes(x = date, y = nitrate_mgL, color = site)) +
              geom_line()+
              geom_point() +
      labs(title = paste("Nitrate Concentrations at", input$site),
           x = "Date",
           y = "Nitrate (mg/L)")
  })
}

# Running the app
shinyApp(ui = ui, server = server)
