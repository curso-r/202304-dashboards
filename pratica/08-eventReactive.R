library(shiny)

ui <- fluidPage(
  titlePanel("Formulário"),
  textInput(
    inputId = "nome",
    label = "Digite o seu nome"
  ),
  dateInput(
    inputId = "data_nascimento",
    label = "Data de nascimento",
    format = "dd/mm/yyyy",
    language = "pt-BR"
  ),
  numericInput(
    inputId = "salario",
    label = "Salário",
    value = 1000,
    step = 50
  ),
  actionButton(inputId = "enviar", label = "Enviar"),
  tableOutput("informacoes")
)

server <- function(input, output, session) {

  tabela <- eventReactive(input$enviar, ignoreNULL = TRUE, {
    tibble::tibble(
      Nome = input$nome,
      `Data de nascimento` = format(input$data_nascimento, "%d/%m/%Y"),
      Salário = input$salario
    )
  })

  output$informacoes <- renderTable({
    tabela()
  })


}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
