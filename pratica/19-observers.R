library(shiny)
library(dplyr)

dados <- pokemon::pokemon_ptbr

ui <- fluidPage(
  titlePanel("Quem é esse Pokemon?"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput(
        inputId = "geracao",
        label = "Selecione a geração",
        choices = na.exclude(unique(dados$id_geracao))
      ),
      selectInput(
        inputId = "pokemon",
        label = "Selecione um pokemon",
        choices = c("Carregando..." = "")
      )
    ),
    mainPanel = mainPanel(
      fluidRow(
        column(
          width = 6,
          offset = 3,
          uiOutput("imagem")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  observe({
    pokemon_da_geracao <- dados |>
      filter(id_geracao == input$geracao) |>
      pull(pokemon)

    updateSelectInput(
      inputId = "pokemon",
      choices = pokemon_da_geracao
    )
  })

  output$imagem <- renderUI({

    req(input$pokemon)

    # validate(
    #   need(isTruthy(input$pokemon), message = "Aguarde um momento...")
    # )

    Sys.sleep(3)

    url <- dados |>
      filter(pokemon == input$pokemon) |>
      pull(url_imagem)

    img(
      src = url,
      width = "100%"
    )

  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
