shinyUI(fluidPage(
  titlePanel("Statistique de corpus latin"),
  
  sidebarLayout(
    sidebarPanel( 
      h4("Cherchez"),
      selectInput(label = "Nom de corpus",
                  choices = list("Patrologia Latina" = "PATROLOGIA_ABBR_IT",
                                 "Vulgata" = "VULGATA") , 
                  inputId = "corpusName"),
      textInput(inputId = "query", label = "Pivot", value = ""),
      actionButton(inputId = "queryButton",label="Search"),
      radioButtons(inputId = "attribute",label = "Attribut", choices = 
                     list("word" = "word","lemma" = "lemma", "pos" = "pos")
      )
      
    ),
    mainPanel(
      tabsetPanel(id = "tabs", type = "tabs",
                  tabPanel(value = "wordFreq" , title = "Word Frequency",
                           h6("freqlem()"),
                           plotOutput(outputId = "plot_freqlem"),
                           h6("freqlem2()"),
                           plotOutput(outputId = "plot_freqlem2"),
                           h6("stablem()"),
                           plotOutput(outputId = "plot_stablem"),
                           h6("freqfrm()"),
                           plotOutput(outputId = "plot_freqfrm")
                  ),
                  tabPanel(value = "wordColloc" , title = "Word Collocates",
                           h3("Table de collocations"),
                           actionButton(inputId = "coocButton",label="Generate Collocation Table"),
                           dataTableOutput(outputId = "wordFreq_coocA"),
                           h3("Graphique de collocations"),
                           actionButton(inputId = "graphCoocButton",label="Generate Collocation Graph"),
                           plotOutput(outputId = "plot_coocB"),
                           plotOutput(outputId = "xxx"),
                           plotOutput(outputId="yyy")
                  ),
                  tabPanel(value = "wordSketch", title = "Mimicking Word Sketch" )
      )
    )
    
  )
  
))
