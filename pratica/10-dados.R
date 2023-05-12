library(shiny)
library(dplyr)

cetesb <- readRDS(here::here("dados/cetesb.rds"))
menor_data <- min(cetesb$data)

ui <- fluidPage(
  titlePanel("Exemplo CETESB"),
  dateInput(
    inputId = "data",
    label = "Selecione a sua data",
    value = menor_data,
    min = menor_data,
    max = max(cetesb$data),
    language = "pt-BR",
    format = "dd/mm/yyyy"
  ),
  tableOutput("tabela")
)

server <- function(input, output, session) {

  output$tabela <- renderTable({
    cetesb |>
      filter(data == input$data) |>
      group_by(estacao_cetesb, poluente) |>
      summarise(
        concentracao_media = mean(concentracao, na.rm = TRUE)
      ) |>
      tidyr::drop_na(concentracao_media) |>
      arrange(estacao_cetesb, poluente) |>
      rename(
        `Estação CETESB` = estacao_cetesb,
        Poluente = poluente,
        `Concentração média` = concentracao_media
      )
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))


