library(shiny)
library(dplyr)
library(ggplot2)

ui <- fluidPage(
  titlePanel("Gráfico mtcars"),
  selectInput(
    inputId = "variavel_mtcars",
    label = "Selecione a variável do eixo X",
    choices = names(mtcars),
    selected = "wt"
  ),
  plotOutput(outputId = "grafico_mtcars"),
  hr(),
  titlePanel("Gráfico StarWars"),
  selectInput(
    inputId = "variavel_starwars",
    label = "Selecione a variável",
    choices = c("hair_color",
                "skin_color",
                "eye_color",
                "sex",
                "gender",
                "homeworld",
                "species")
  ),
  plotOutput(outputId = "grafico_starwars")
)

server <- function(input, output, session) {

  output$grafico_mtcars <- renderPlot({
    print("Rodei o gráfico mtcars")
    plot(x = mtcars[[input$variavel_mtcars]], y = mtcars$mpg)
  })

  output$grafico_starwars <- renderPlot({
    print("Rodei o gráfico starwars")
    ggplot(starwars) +
      geom_bar(aes(x = .data[[input$variavel_starwars]]))
  })

}

shinyApp(ui, server)
