library(shiny)
library(tidyverse)
library(markdown)

source("R/helper.R")
msa_hpi = read_csv("data/msa_hpi_clean.csv")

state_choices = msa_hpi %>%
  distinct(state) %>%
  arrange(state) %>%
  pull(state)

year_range = range(msa_hpi$year, na.rm = TRUE)

ui = navbarPage(
  title = "Metropolitan Statistical Area House Price",
  tabPanel(
    "Market Trends",
    titlePanel(title = "MSA Date: 2000 - 2025"),
    sidebarLayout(
      sidebarPanel(
        selectInput(
          inputId = "state",
          label = "Choose a state:",
          choices = state_choices,
          selected = "IL"
        ),
        radioButtons(
          inputId = "area_type",
          label = "Area type:",
          choices = c("Single MSA", "All MSAs in state"),
          selected = "Single MSA"
        ),
        uiOutput("msa_ui"),
        sliderInput(
          inputId = "year_range",
          label = "Year range:",
          min = year_range[1],
          max = year_range[2],
          value = year_range,
          step = 1,
          sep = ""
        )
      ),
      mainPanel(
        plotOutput("hpi_plot"),
        br(),
        textOutput("summary_text")
      )
    )
  ),

# Data Table
  tabPanel(
    title = "Data Table",
    fluidPage(
      h3("Filtered data"),
      tableOutput("hpi_table")
    )
  ),

# About
  tabPanel(
    title = "About",
    includeMarkdown("About.Rmd")
    )
)


server = function(input, output, session) {

  output$msa_ui = renderUI({
    if (input$area_type == "Single MSA") {
      msa_choices = msa_hpi %>%
        filter(state == input$state) %>%
        distinct(msa_name) %>%
        arrange(msa_name) %>%
        pull(msa_name)

      selectInput(
        inputId = "msa",
        label = "Choose a metro area:",
        choices = msa_choices,
        selected = "Champaign-Urbana, IL"
      )
    }
  })

  filtered_data = reactive({
    req(input$state)

    filter_msa_data(
      data = msa_hpi,
      state_choice = input$state,
      area_type = input$area_type,
      msa_choice = input$msa,
      year_range = input$year_range
    )
  })

# Plot output
  output$hpi_plot = renderPlot({
    df = filtered_data()
    p = ggplot(df, aes(x = date, y = hpi_index)) +
      geom_line(aes(group = msa_id, color = msa_name)) +
      labs(
        x = "Date",
        y = "House Price Index (Non-Seasonally Adjusted, all-transactions)",
        color = "Metro area"
      )

    if (input$area_type == "Single MSA" && !is.null(input$msa)) {
      p = p + ggtitle(paste0("House Price Index for ", input$msa))
    } else {
      p = p + ggtitle(paste0("House Price Index for MSAs in ", input$state))
    }

    p
  })

# text output
  output$summary_text = renderText({
    df = filtered_data() %>%
      arrange(date)

    if (nrow(df) < 2) {
      return("Not enough data in the selected range to compute summary.")
    }

    start_val = df$hpi_index[1]
    end_val = df$hpi_index[nrow(df)]
    pct_change = (end_val / start_val - 1) * 100

    label = if (input$area_type == "Single MSA" && !is.null(input$msa)) {
      input$msa
    } else {
      paste("all MSAs in", input$state)
    }

    paste0(
      "From ", df$year[1], " Q", df$quarter[1], " to ", df$year[nrow(df)], " Q", df$quarter[nrow(df)], ", the HPI for ", label, " changed from ", start_val, " to ", end_val, " (", round(pct_change, 2), "% change)." )
  })

  output$hpi_table = renderTable({
    filtered_data() %>%
      arrange(msa_name, date)
  })

}
# Run the application
shinyApp(ui = ui, server = server)
