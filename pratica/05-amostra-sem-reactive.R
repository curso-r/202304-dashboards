library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  titlePanel("Resultado de um sorteio"),
  sliderInput(
    inputId = "tamanho_amostra",
    label = "Tamanho da amostra",
    min = 1,
    max = 1000,
    value = 100
  ),
  plotOutput("grafico"),
  textOutput("texto")
)

server <- function(input, output, session) {

  # Essa solução não funciona
  # amostra <- sample(1:10, size = input$tamanho_amostra, replace = TRUE)

  output$grafico <- renderPlot({
    tibble::tibble(
      valores = amostra
    ) |>
      ggplot() +
      geom_bar(aes(x = valores)) +
      scale_x_continuous(breaks = 1:10)
  })

  output$texto <- renderText({
    valor_mais_sorteado <- tibble::tibble(
      valores = amostra
    ) |>
      count(valores, name = "contagem") |>
      slice_max(order_by = contagem, n = 1) |>
      pull(valores)

    texto <- paste(valor_mais_sorteado, collapse = ", ")

    glue::glue("O valor(es) mais sorteado(s) foi: {texto}")

  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
