# Loading the packages
library(shiny)
library(ggplot2)
library(shinythemes)

# Loading the data from the package
data("nitrates_small", package = utils::packageName())

# Mapping site codes
site_map <- c(
  "ARIK" = "Arikaree River (ARIK)",
  "CARI" = "Caribou Creek (CARI)",
  "LEWI" = "Lewis Run (LEWI)"
)

# UI
ui <- fluidPage(
  theme = shinytheme("flatly"),
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "styles.css")),
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
      max = max(nitrates_small$date)
    ),

    tags$hr(),
    h4("About this app"),
    helpText(
      "Explore daily nitrate concentrations (mg/L) for three NEON river sites from June 2019 to July 2019. ",
      "Use the checkboxes and date range to focus on a site or period and compare patterns."
  ),

  tags$hr(),
  h4("What these variables mean"),
  tags$ul(
    tags$li(tags$code("site"), " — Name of NEON site."),
    tags$li(tags$code("date"), " — Date range between June - July 2019."),
    tags$li(tags$code("nitrate_mgL"), " — Daily mean nitrate (mg/L).")
  ),

  tags$hr(),
  h4("How to interpret the plot"),
  helpText(
    "The lines indicate the how nitrate levels at the three sites changed over time. ",
    "Use the location checkboxes and date range to focus on a site or period and compare patterns."
    )
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
