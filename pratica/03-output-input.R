library(shiny)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Gráfico de dispersão"),
  selectInput(
    inputId = "variavel_x",
    label = "Variável do eixo X",
    choices = names(mtcars),
    selected = "wt"
  ),
  selectInput(
    inputId = "variavel_y",
    label = "Variável do eixo Y",
    choices = names(mtcars),
    selected = "mpg"
  ),
  plotOutput(outputId = "grafico"),
  plotOutput(outputId = "grafico_ggplot")
)

server <- function(input, output, session) {

  output$grafico <- renderPlot({
    plot(x = mtcars[[input$variavel_x]], y = mtcars[[input$variavel_y]])
  })

  output$grafico_ggplot <- renderPlot({
      ggplot(mtcars) +
      geom_point(
        aes(x = .data[[input$variavel_x]], y = .data[[input$variavel_y]])
      )
  })

}

shinyApp(ui, server)
