# STRUTTURA LINK INTERNI
# "./" == "./www/"
# "./HTML" == "./www/HTML"
# library(shiny)


# alla compilazione vengono 
# introdotti tutti i file presenti nella cartella R/

spec(amazonMovies)
spec(disneyMovies)
spec(netflixMovies)


mainUI = fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "./STYLES/main.css")),
  h1(id = "title","MOVIE DATA ANALISYS"),
  p(id = "info","Fumagalli Damiano --- IBML 6 CFU"),
  p(id="c",a(id = "startLink","START PRESENTATION", href="./HTML/Presentation.html")),
  
  h3(id = "indexTitle","INDEX"),
  radioButtons("chosenAPP","CHOOSE THE APP",choiceNames = c("Reccomendation System","MOVIELENS User MAPS"), choiceValues = c("RS","UM")),
  actionButton("invia","LAUNCH APP"),
  uiOutput("outUI")
)

usersMap_UI = fluidPage(
  h2("","MOVIELENS USERS MAPPING"),
  radioButtons("param","choose the parameter",choiceNames =  c("genre","occupation"), choiceValues = c("G","O")),
  actionButton("start","GO"),
  uiOutput("choiceUI"),
  plotOutput("plotOut")
)



reccomendAPP_UI = fluidPage(
  h2(id = "","Reccomendation System"),
  checkboxGroupInput("platform",label = "Choose your straming services", choiceNames = c("None","Amazon Prime Video","Disney +","Netflix"),choiceValues = c("none","amazon","disney","netflix")),
  radioButtons("movieType",label = "Choose the movie Type",choiceNames = c("Movie","TV-Shows"), choiceValues = c("M","T")),
  radioButtons("arrangeBy","Arrange BY",choices = c("year","duration","oscarNominees")),
  radioButtons("order","Select Order",choiceNames  = c("Ascending","Descending"), choiceValues = c("A","D")),
  actionButton("print","SEND"),
  textOutput("printout"),
  tableOutput("printTable")
)



chooseOCC_UI = fluidPage(
  selectInput("OCC","Choose the JOB",choices = workTable$workType),
  radioButtons("label","SHOW STATE NAMES", choices = c("YES","NO")),
  actionButton("sendOCC","RENDER PLOT")
)

chooseGEN_UI = fluidPage(
  selectInput("GEN","Choose the GENRE",choices = MLGenres$genre),
  radioButtons("label","SHOW STATE NAMES", choices = c("YES","NO")),
  actionButton("sendGEN","RENDER PLOT")
)












server <-  function(input,output){
  # CHOOSE APPs UI
  appUI = eventReactive(input$invia,{
    if (input$chosenAPP == "RS") {
      reccomendAPP_UI  
    } else if (input$chosenAPP == "UM") {
      usersMap_UI
    }
  })
  output$outUI = renderUI( { appUI() } )
  
  # MAP UI SELECT PARAMETER
  MAPUI = eventReactive(input$start,{
    if (input$param == "G"){
      chooseGEN_UI
    } else {
      chooseOCC_UI
    }
  })
  output$choiceUI = renderUI({
    MAPUI()
  })
  
  genMAP = eventReactive(input$sendGEN,{
    usersMap(c(input$label,input$GEN), input$param)
  })
  
  occMAP = eventReactive(input$sendOCC,{
    usersMap( c(input$label,input$OCC) , input$param)
  })
  
  output$plotOut = renderPlot({
    if (input$param == "G"){
      genMAP()
    } else {
      occMAP()
    }
  })
  
  # reccomendation
   reccTable = eventReactive(input$print,{
      compiledList = list(platform = sort(input$platform),movieType = input$movieType, arrange = input$arrangeBy, order = input$order)
     reccomendAPP(compiledList)
   })
    output$printTable = renderTable({
      reccTable()
     })
    
    
    
    
    
    
   
    
  }

# Run the application 
shinyApp(ui = mainUI, server = server)
