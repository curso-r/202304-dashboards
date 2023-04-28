library(shiny)
library(ggplot2)

ui <- fluidPage(
  "Um gráfico de dispersão",
  plotOutput(outputId = "grafico_dispersao"),
  plotOutput(outputId = "grafico_barras"),
  textOutput(outputId = "texto")
)

server <- function(input, output, session) {

  output$grafico_dispersao <- renderPlot({
    plot(x = mtcars$wt, y = mtcars$mpg)
  })

  output$grafico_barras <- renderPlot({
    ggplot(mtcars) +
      geom_bar(aes(x = cyl))
  })

  output$texto <- renderText({
    paste("A hora agora é:", Sys.time())
  })

}

shinyApp(ui, server)
