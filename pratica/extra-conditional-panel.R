library(shiny)

ui <- fluidPage(
  # tags$head(
  #   tags$link(rel = "stylesheet", href = "custom.css")
  # ),
  titlePanel("Exemplo com conditional panel"),
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = "area",
        label = "Selecione a área",
        choices = c("Financeiro", "Administrativo", "Comercial")
      ),
      hr(),
      conditionalPanel(
        condition = "input.area == 'Financeiro'",
        textInput(
          "cnpj_empresa",
          label = "CNPJ",
          value = ""
        ),
        numericInput(
          "valor_nota",
          label = "Valor da nota",
          value = 1000
        )
      ),
      conditionalPanel(
        condition = "input.area == 'Administrativo'",
        selectInput(
          "item",
          label = "Selecione o item",
          choices = c("Material de escritório", "Mobiliário", "Coffee-break")
        ),
        numericInput(
          "valor_compra",
          label = "Valor da compra",
          value = 0
        )
      ),
      conditionalPanel(
        condition = "input.area == 'Comercial'",
        selectInput(
          "cliente",
          label = "Selecione o cliente",
          choices = c("Cliente 1", "Cliente 2", "Cliente 3", "Cliente 4")
        ),
        actionButton(
          "enviar_email",
          label = "Enviar e-mail"
        )
      )
      # uiOutput("filtros")
    ),
    mainPanel()
  )
)

server <- function(input, output, session) {

  # output$filtros <- renderUI({
  #
  #   if (input$area == "Financeiro") {
  #     tagList(
  #       textInput(
  #         "cnpj_empresa",
  #         label = "CNPJ",
  #         value = ""
  #       ),
  #       numericInput(
  #         "valor_nota",
  #         label = "Valor da nota",
  #         value = 1000
  #       )
  #     )
  #   } else if (input$area == "Administrativo") {
  #     tagList(
  #       selectInput(
  #         "item",
  #         label = "Selecione o item",
  #         choices = c("Material de escritório", "Mobiliário", "Coffee-break")
  #       ),
  #       numericInput(
  #         "valor_compra",
  #         label = "Valor da compra",
  #         value = 0
  #       )
  #     )
  #   } else {
  #     tagList(
  #       selectInput(
  #         "cliente",
  #         label = "Selecione o cliente",
  #         choices = c("Cliente 1", "Cliente 2", "Cliente 3", "Cliente 4")
  #       ),
  #       actionButton(
  #         "enviar_email",
  #         label = "Enviar e-mail"
  #       )
  #     )
  #   }
  #
  # })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
