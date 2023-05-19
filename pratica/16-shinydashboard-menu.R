library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(title = "ShinyDashboard"),
  dashboardSidebar(
    sidebarMenu(
      menuItem(
        text = "Página 1",
        tabName = "pagina_1",
        icon = icon("igloo")
      ),
      menuItem(
        text = "Página 2",
        tabName = "pagina_2",
        icon = icon("instagram")
      ),
      menuItem(
        text = "Páginas agrupadas",
        menuSubItem(
          text = "Página 3",
          tabName = "pagina_3",
          icon = icon("skull-crossbones")
        ),
        menuSubItem(
          text = "Página 4",
          tabName = "pagina_4"
        )
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = "pagina_1",
        titlePanel("Conteúdo da página 1")
      ),
      tabItem(
        tabName = "pagina_2",
        titlePanel("Conteúdo da página 2")
      ),
      tabItem(
        tabName = "pagina_3",
        titlePanel("Conteúdo da página 3")
      ),
      tabItem(
        tabName = "pagina_4",
        titlePanel("Conteúdo da página 4")
      )
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
