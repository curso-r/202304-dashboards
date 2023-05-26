library(shiny)

dados <- mtcars[,1:5] |>
  dplyr::mutate(linha = dplyr::row_number(), .before = 1)

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      titlePanel("Remover uma linha"),
      numericInput(
        inputId = "linha_para_remover",
        label = "Escolha uma linha para remover",
        value = 1,
        min = 1,
        max = nrow(dados)
      ),
      actionButton(
        inputId = "remover_linha",
        label = "Remover linha selecionada"
      ),
      hr(),
      titlePanel("Adicionar uma linha"),
      numericInput(
        inputId = "mpg",
        label = "Escolha um valor para a coluna mpg",
        value = 30,
        min = 1,
        max = 100
      ),
      actionButton(
        inputId = "adicionar_linha",
        label = "Adicionar linha à base"
      )
    ),
    mainPanel(
      tableOutput("tabela")
    )
  )
)

server <- function(input, output, session) {

  dados_reativo <- reactiveVal(dados)

  observeEvent(input$remover_linha, {
    nova_base <- dados_reativo() |>
      dplyr::filter(linha != input$linha_para_remover)
    dados_reativo(nova_base)
  })

  observeEvent(input$adicionar_linha, {
    maior_linha <- max(dados_reativo()$linha)
    nova_base <- dados_reativo() |>
      tibble::add_row(linha = maior_linha + 1, mpg = input$mpg)
    dados_reativo(nova_base)
  })

  output$tabela <- renderTable({
    dados_reativo()
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
