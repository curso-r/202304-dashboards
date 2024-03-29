library(shiny)

ui <- fluidPage(
  "Sorteio de números de 1 a 10",
  sliderInput(
    inputId = "tamanho",
    label = "Selecione o tamanho da amostra",
    min = 1,
    max = 1000,
    value = 5
  ),
  actionButton("sortear", "Sortear"),
  plotOutput(outputId = "grafico"),
  "Tabela de frequências",
  tableOutput(outputId = "tabela")
)

server <- function(input, output, session) {

  amostra <- eventReactive(input$sortear, {
    sample(1:10, input$tamanho, replace = TRUE)
  })

  output$grafico <- renderPlot({
    browser()
    amostra() |>
      table() |>
      barplot()
  })

  output$tabela <- renderTable({
    data.frame(
      numeros = amostra()
    ) |>
      dplyr::count(numeros)
  })

}

shinyApp(ui, server,  options = list(launch.browser = FALSE, port = 4242))
