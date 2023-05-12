library(shiny)

ui <- fluidPage(
  h1("Exemplo de HTML no Shiny"),
  h2("Aqui poderia ter um subtítulo"),
  hr(),
  p("Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Donec nec consequat sapien. Mauris tristique ac metus nec
    rhoncus. Vestibulum commodo ante ipsum, sed sagittis nibh
    feugiat euismod. Mauris efficitur commodo justo, nec faucibus
    nibh pretium a. Etiam ornare ante ipsum, ac mollis mi pulvinar
    eu.",
    strong("Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Donec nec consequat sapien. Mauris tristique ac metus nec
    rhoncus. Vestibulum commodo ante ipsum, sed sagittis nibh
    feugiat euismod. Mauris efficitur commodo justo, nec faucibus
    nibh pretium a. Etiam ornare ante ipsum, ac mollis mi pulvinar
    eu.", .noWS = c("before")),
    .noWS = c("after")
    ),
  p("Lorem ipsum dolor sit amet, consectetur adipiscing elit.
    Donec nec consequat sapien. Mauris tristique ac metus nec
    rhoncus. Vestibulum commodo ante ipsum, sed sagittis nibh
    feugiat euismod. Mauris efficitur commodo justo, nec faucibus
    nibh pretium a. Etiam ornare ante ipsum, ac mollis mi pulvinar
    eu."),
  img(
    src = "logo.png"
  )
)

server <- function(input, output, session) {

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))
