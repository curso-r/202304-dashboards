library(shiny)

ui <- navbarPage(
  title = "App com navbarPage",
  tabPanel(
    title = "Página 1",
    titlePanel("Conteúdo da página 1"),
    selectInput(
      inputId = "letra",
      label = "Selecione o valor",
      choices = c("a", "b", "c")
    ),
    textOutput(outputId = "texto")
  ),
  tabPanel(
    title = "Página 2",
    titlePanel("Conteúdo da página 2"),
    selectInput(
      inputId = "letra_pag2",
      label = "Selecione o valor",
      choices = c("a", "b", "c")
    ),
    textOutput(outputId = "texto_pag2")
  ),
  navbarMenu(
    title = "Páginas agrupadas",
    tabPanel(
      title = "Página 3",
      titlePanel("Conteúdo da página 3"),
      sidebarLayout(
        sidebarPanel(
          selectInput(
            inputId = "letra_pag3",
            label = "Selecione o valor",
            choices = c("a", "b", "c")
          )
        ),
        mainPanel(
          textOutput(outputId = "texto_pag3")
        )
      )
    ),
    tabPanel(
      title = "Página 4",
      titlePanel("Conteúdo da página 4")
    ),
    tabPanel(
      title = "Página 5",
      titlePanel("Conteúdo da página 5")
    ),
  )
)

server <- function(input, output, session) {

  output$texto <- renderText({
    input$letra
  })

  output$texto_pag2 <- renderText({
    input$letra_pag2
  })

  output$texto_pag3 <- renderText({
    input$letra_pag3
  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
