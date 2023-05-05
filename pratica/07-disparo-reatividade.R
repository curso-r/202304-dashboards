library(shiny)

ui <- fluidPage(
  textInput(inputId = "entrada", label = "Escreva um texto"),
  textOutput(outputId = "saida")
)

server <- function(input, output, session) {

  texto <- reactive({
    print("Rodou a função reactive!")
    toupper(input$entrada)
  })

  output$saida <- renderText({
    print("Rodou a função render!")
    input$entrada
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
