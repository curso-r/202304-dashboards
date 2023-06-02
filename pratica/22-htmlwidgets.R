library(shiny)
library(bs4Dash)
library(dplyr)
library(ggplot2)

pnud <- abjData::pnud_min

regioes <- sort(unique(pnud$regiao_nm))

indices <- c(
  "Indice de desenvolvimento humano" = "idhm",
  "Esperanca de vida" = "espvida",
  "Renda per capita" = "rdpc",
  "Indice de GINI" = "gini",
  "Populacao" = "pop"
)

ui <- bs4DashPage(
  bs4DashNavbar(title = "HTMLWIDGETS"),
  bs4DashSidebar(
    bs4SidebarMenu(
      bs4SidebarMenuItem(
        text = "reactable",
        tabName = "reactable"
      ),
      bs4SidebarMenuItem(
        text = "graficos",
        bs4SidebarMenuSubItem(
          text = "plotly",
          tabName = "plotly"
        ),
        bs4SidebarMenuSubItem(
          text = "echarts",
          tabName = "echarts"
        )
      ),
      bs4SidebarMenuItem(
        text = "leaflet",
        tabName = "leaflet"
      )
    )
  ),
  bs4DashBody(
    bs4TabItems(
      bs4TabItem(
        tabName = "reactable",
        titlePanel("Tabelas com reactable"),
        hr(),
        fluidRow(
          bs4Card(
            title = "Filtros",
            width = 12,
            fluidRow(
              column(
                width = 4,
                selectInput(
                  inputId = "reactable_ano",
                  label = "Selecione um ano",
                  choices = sort(unique(pnud$ano), decreasing = TRUE),
                  width = "80%"
                )
              ),
              column(
                width = 4,
                selectInput(
                  inputId = "reactable_regiao",
                  label = "Selecione uma região",
                  choices = regioes,
                  multiple = TRUE,
                  selected = regioes,
                  width = "80%"
                )
              ),
              column(
                width = 4,
                selectInput(
                  inputId = "reactable_indice",
                  label = "Selecione um índice",
                  choices = indices,
                  width = "80%"
                )
              )
            )
          )
        ),
        reactable::reactableOutput(outputId = "reactable")
      ),
      bs4TabItem(
        tabName = "plotly",
        titlePanel("Gráficos com plotly"),
        hr(),
        fluidRow(
          bs4Card(
            title = "Filtros",
            width = 12,
            fluidRow(
              column(
                width = 6,
                selectInput(
                  inputId = "plotly_indice_x",
                  label = "Selecione um índice para o eixo X",
                  choices = indices,
                  width = "80%",
                  selected = "idhm"
                )
              ),
              column(
                width = 6,
                selectInput(
                  inputId = "plotly_indice_y",
                  label = "Selecione um índice para o eixo Y",
                  choices = indices,
                  width = "80%",
                  selected = "espvida"
                )
              )
            )
          )
        ),
        plotly::plotlyOutput(outputId = "ggplotly"),
        plotly::plotlyOutput(outputId = "plotly")
      ),
      bs4TabItem(
        tabName = "echarts",
        titlePanel("Gráficos com echarts"),
        hr(),
        fluidRow(
          bs4Card(
            title = "Filtros",
            width = 12,
            fluidRow(
              column(
                width = 4,
                selectInput(
                  inputId = "echarts_uf",
                  label = "Selecione um estado",
                  choices = sort(unique(pnud$uf_sigla))
                )
              ),
              column(
                width = 4,
                selectInput(
                  inputId = "echarts_muni",
                  label = "Selecione um município",
                  choices = c("Carregando..." = "")
                )
              ),
              column(
                width = 4,
                selectInput(
                  inputId = "echarts_indice",
                  label = "Selecione um índice",
                  choices = indices,
                  width = "80%"
                )
              )
            )
          )
        ),
        echarts4r::echarts4rOutput("echart")
      ),
      bs4TabItem(
        tabName = "leaflet",
        titlePanel("Mapas com leaflet"),
        hr(),
        fluidRow(
          bs4Card(
            title = "Filtros",
            width = 12,
            fluidRow(
              column(
                width = 4,
                selectInput(
                  inputId = "leaflet_ano",
                  label = "Selecione um ano",
                  choices = sort(unique(pnud$ano), decreasing = TRUE),
                  width = "80%"
                )
              ),
              column(
                width = 4,
                selectInput(
                  inputId = "leaflet_estado",
                  label = "Selecione um estado",
                  choices = sort(unique(pnud$uf_sigla)),
                  width = "80%"
                )
              ),
              column(
                width = 4,
                selectInput(
                  inputId = "leaflet_indice",
                  label = "Selecione um índice",
                  choices = indices,
                  width = "80%"
                )
              )
            )
          )
        ),
        leaflet::leafletOutput(
          outputId = "leaflet",
          height = "600px"
        )
      )
    )
  )
)


server <- function(input, output, session) {

  output$reactable <- reactable::renderReactable({

    pnud |>
      filter(
        regiao_nm %in% input$reactable_regiao,
        ano == input$reactable_ano
      ) |>
      arrange(desc(.data[[input$reactable_indice]])) |>
      mutate(
        rank = row_number()
      ) |>
      select(
        "Rank" = rank,
        "Município" = muni_nm,
        "UF" = uf_sigla,
        "IDHM" = idhm,
        "Esperaça de vida" = espvida,
        "Renda" = rdpc,
        "GINI" = gini,
        "População" = pop
      ) |>
      reactable::reactable(
        defaultPageSize = 15,
        searchable = TRUE,
        striped = TRUE,
        language = reactable::reactableLang(
          searchPlaceholder = "Procurar..."
        )
      )

  })


  output$ggplotly <- plotly::renderPlotly({

    p <- pnud |>
      filter(ano == max(ano)) |>
      ggplot() +
      geom_point(aes(
        x = .data[[input$plotly_indice_x]],
        y = .data[[input$plotly_indice_y]],
        text = muni_nm
      )) +
      theme_minimal()

    plotly::ggplotly(p, tooltip = "text")

  })

  output$plotly <- plotly::renderPlotly({
    pnud |>
      filter(ano == max(ano)) |>
      rename(
        x = input$plotly_indice_x,
        y = input$plotly_indice_y
      ) |>
      plotly::plot_ly(
        x = ~x,
        y = ~y,
        type = "scatter"
      )
  })


  observe({
    municipios <- pnud |>
      filter(uf_sigla == input$echarts_uf) |>
      pull(muni_nm) |>
      unique() |>
      sort()

    updateSelectInput(
      inputId = "echarts_muni",
      choices = municipios
    )
  })

  output$echart <- echarts4r::renderEcharts4r({
    pnud |>
      filter(
        muni_nm == input$echarts_muni
      ) |>
      echarts4r::e_chart(
        x = ano
      ) |>
      echarts4r::e_bar_(serie = input$echarts_indice) |>
      echarts4r::e_legend(show = FALSE) |>
      echarts4r::e_x_axis(
        name = "Ano",
        nameLocation = "center",
        nameGap = 30
      ) |>
      echarts4r::e_y_axis(
        name = input$echarts_indice,
        nameLocation = "center",
        nameGap = 30
      ) |>
      echarts4r::e_tooltip()
  })


  output$leaflet <- leaflet::renderLeaflet({

    pnud |>
      filter(
        ano == input$leaflet_ano,
        uf_sigla == input$leaflet_estado
      ) |>
      arrange(
        desc(.data[[input$leaflet_indice]])
      ) |>
      slice(1:10) |>
      mutate(
        texto_popup = paste0(
          input$leaflet_indice,
          ": ",
          .data[[input$leaflet_indice]]
        )
      ) |>
      leaflet::leaflet() |>
      leaflet::addTiles() |>
      leaflet::addMarkers(
        lng = ~lon,
        lat = ~lat,
        label = ~muni_nm,
        popup = ~texto_popup
      )

  })

}

shinyApp(ui, server, options = list(launch.browser = FALSE, port = 4242))














