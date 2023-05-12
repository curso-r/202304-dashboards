quadrado <- function(text = "") {
  div(
    style = "background: purple; height: 200px; text-align: center; color: white; font-size: 24px;",
    text
  )
}

library(shiny)

ui <- fluidPage(
  fluidRow(
    column(
      width = 4,
      quadrado("Coluna tam 4")
    ),
    column(
      width = 2,
      quadrado("Caluna tam 2")
    )
  ),
  br(),
  fluidRow(
    column(
      width = 4,
      quadrado("Coluna tam 4")
    ),
    column(
      width = 4,
      quadrado("Coluna tam 4")
    ),
    column(
      width = 4,
      quadrado("Coluna tam 4")
    )
  ),
  fluidRow(
    column(
      width = 3,
      offset = 2,
      quadrado("Coluna tam 3")
    ),
    column(
      width = 5,
      offset = 2,
      quadrado("Coluna tam 5")
    )
    # Má prática ter linhas com mais de 12 colunas
    # column(
    #   width = 1,
    #   quadrado("Coluna tam 1")
    # )
  ),
  fluidRow(
    column(
      width = 1,
      quadrado("Coluna tam 1")
    )
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
