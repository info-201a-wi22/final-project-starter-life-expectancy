# App

library("shiny")

# Source ui and server
source("app_ui.R")
source("app_server.R")

# Create new shinyApp
shinyApp(ui = ui, server = server)