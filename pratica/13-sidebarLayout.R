library(shiny)
library(dplyr)

# dados <- readRDS(here::here("dados/pkmn.rds"))
dados <- pokemon::pokemon_ptbr

ui <- fluidPage(
  titlePanel("Quem é esse Pokemon?"),
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      selectInput(
        inputId = "pokemon",
        label = "Selecione um pokemon",
        choices = unique(dados$pokemon)
      )
    ),
    mainPanel = mainPanel(
      fluidRow(
        column(
          width = 6,
          offset = 3,
          # imageOutput("imagem"),
          uiOutput("imagem")
        )
      )
    )
  )
)

server <- function(input, output, session) {

  # output$imagem <- renderImage({
  #
  #   url <- dados |>
  #     filter(pokemon == input$pokemon) |>
  #     pull(url_imagem)
  #
  #   arquivo <- tempfile(fileext = ".png")
  #   httr::GET(url, httr::write_disk(arquivo, overwrite = TRUE))
  #   # download.file(url, arquivo)
  #
  #   list(
  #     src = arquivo,
  #     width = "100%"
  #   )
  #
  # })

  output$imagem <- renderUI({

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
