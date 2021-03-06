# Define a Interface de Usuario
ui = tagList(
  includeCSS("estilo.css"),
  tags$head(HTML("<title>Simulador Fundeb</title>")),
  shinyWidgets::useShinydashboard(),
  ## Define UI como pagina de navegacao
  navbarPage(
    theme = shinytheme("flatly"),
    ### Define Tema
    ### Barra 1
    title = div(img(src = 'logo.png', style = "margin-top: -20px; margin-left: -20px; padding-right:-0px; padding-bottom:10px", height = 70)),
    selected = "Simulação",
    tabPanel(
      title = "Simulação",
      fluidRow(
        column(12,
        ### Complementacao da União
        h2("Complementação da União")),
        column(5,
               shinyWidgets::autonumericInput(width = "100%",
          "complementacao_vaaf",
          "Montante da Complementação VAAF (em milhões):",
          value = 20529,
          align = "left",
          decimalCharacter = ",",
          digitGroupSeparator = ".",
          decimalPlaces = 0,
          min = 0,
        )),
        column(5,
               shinyWidgets::autonumericInput(width = "100%",
          "complementacao_vaat",
          "Montante da Complementação VAAT (em milhões):",
          value = 10264,
          align = "left",
          decimalCharacter = ",",
          digitGroupSeparator = ".",
          decimalPlaces = 0,
          min = 0
        )),
        column(2, 
        actionButton("botao", "Simular", width = "100%",
                     style='font-size:200%'))),
        fluidRow(
        ### Parametros fiscais e sociais
        column(4,
               wellPanel(
        h2("Fator por parâmetro social e fiscal"),
        sliderInput(
          "social",
          "Parâmetros Social:",
          min = 1,
          max = 2,
          value = c(1)
        ),
        sliderInput(
          "fiscal",
          "Parâmetros Fiscal:",
          min = 1,
          max = 2,
          value = c(1)
        )),
        # Pesos por etapa e modalidade
        wellPanel(
        h2("Fator por Tipo e Modalidade"),
        uiOutput("pesos")
      )),
      ## Tabela com resultados
      column(8,
        h1("Informações Básicas"),
        ### Linha com os infoboxes
          shinydashboard::infoBox(
            "VAAT Máximo",
            uiOutput("box_max_vaat"),
            icon = icon("line-chart"),
            color = "orange",
            fill = TRUE
          ),
          shinydashboard::infoBox(
            "VAAT Médio",
            uiOutput("box_media_vaat"),
            icon = icon("line-chart"),
            color = "purple",
            fill = TRUE
          ),
            shinydashboard::infoBox(
              HTML(paste("VAAT Mínimo", br(), "Ente habilitados")),
            uiOutput("box_min_vaat"),
            icon = icon("line-chart"),
            color = "yellow",
            fill = TRUE
          ),
          shinydashboard::infoBox(
            HTML(paste("VAAT Médio", br(), "Quintil inferior")),
            uiOutput("box_mean_vaat_quintil"),
            icon = icon("line-chart"),
            color = "green",
            fill = TRUE
          ),
          shinydashboard::infoBox(
            HTML(paste("Complementação da", br(), "União aos Municípios")),
            uiOutput("box_compl_municipal"),
            icon = icon("line-chart"),
            color = "blue",
            fill = TRUE
          ),
          shinydashboard::infoBox(
            HTML(paste("Complementação da", br(), "ao Estados")),
            uiOutput("box_compl_estadual"),
            icon = icon("line-chart"),
            color = "aqua",
            fill = TRUE
          ),
        ### Gráfico com complementação de recursos por unidade da federação
        br(),
        h1("Síntese dos números do VAAT – 2022"),
        HTML("<ul><li>Os gráficos abaixo apresentam a distribuição do VAAT segundo o cálculo do MEC e segundo a estimativa de recursos recebidos por aluno para 2022.</li></li</ul>"),
        br(),
        shinycssloaders::withSpinner(plotly::plotlyOutput("graf_dispersao_ente")),
        HTML("O grafico acima apresenta a estimativa do VAAT de 2020 corrigido pela infalação com a complementação VAAT de 2022. Ou seja, apresenta o valor total a ser recebido pelo ente considerando: <ul><li>Receitas de 2020 corrigidas pela infalação;</li> <li>Complementação VAAF realizada em 2020 corrigida pela inflação;</li><li>Complementação VAAT com base nos valores de 2020 corrigidos pela inflação.</li>"),
        br(),
        shinycssloaders::withSpinner(plotly::plotlyOutput("graf_dispersao_total_recebido")),
        HTML("O grafico acima apresenta a estimativa do VAAT em 2022. Ou seja, apresenta o valor total a ser recebido pelo ente considerando: <ul><li>Estimativa de receitas de 2022;</li> <li>Complementação VAAF com base nos valores estimados de  2022;</li><li>Complementação VAAT com base nos valores de 2020 corrigidos pela inflação.</li>"),
        br(),
        br(),
        h1("Síntese da Dispersão"),
        br(),
        shinycssloaders::withSpinner(plotly::plotlyOutput("graf_dispersao")),
        br(),
        shinycssloaders::withSpinner(plotly::plotlyOutput("graf_decil_saeb")),
        HTML("<ul><li>O gráfico acima divide os entes federados em dez décis de acordo com o indicador socioeconômico como calculado pelo SAEB 2019;<li>O primeiro décil contém os entes com os 10% piores indicadores, o segundo décil os entes entre o 11% e 20% piores indicadores e assim sucessivamente</li></li</ul>"),
        br(),
        h1("Síntese da Complementação da União – 2022"),
        shinycssloaders::withSpinner(plotly::plotlyOutput("graf_complementacao_federal")),
        br(),
        h1("Tabela com os resultados"),
        ### Tabela com resultados da simulação
        shinycssloaders::withSpinner(DT::dataTableOutput("simulacao_dt"))
        
      ))
      
    ),
    tabPanel("Documentação",
             column(2),
             column(8,
                    withMathJax(
                      shiny::includeMarkdown("documentacao.md")
                    )))
  ),
  tags$footer(HTML("
                    <!-- Footer -->
                           <footer class='page-footer font-large indigo'>
                           <br>
                           <!-- Copyright -->
                           <div class='footer-copyright text-center py-3'>© 2022 Copyright:
                           <a href='https://todospelaeducacao.org.br/'> Todos pela Educação</a>
                           </div>
                           <!-- Copyright -->
                           <br>

                           </footer>
                           <!-- Footer -->"))
)
