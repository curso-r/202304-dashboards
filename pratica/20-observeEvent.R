library(shiny)

ui <- fluidPage(
  textInput(
    inputId = "email",
    label = "Digite o seu e-mail",
    value = ""
  ),
  actionButton(
    "enviar",
    label = "Enviar dados"
  )
)

server <- function(input, output, session) {

  observeEvent(input$enviar, {

    teste <- stringr::str_detect(input$email, "@")

    if(teste == TRUE) {
      write(input$email, "emails.txt", append = TRUE)
      mensagem <- "O seu e-mail foi salvo!"
      titulo <- "Sucesso!"
    } else {
      mensagem <- "O seu e-mail é inválido! Ele não foi salvo."
      titulo <- "Erro!"
    }

    showModal(
      modalDialog(
        title = titulo,
        footer = modalButton("Fechar"),
        mensagem,
        easyClose = TRUE
      )
    )

  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
