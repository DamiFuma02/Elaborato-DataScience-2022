# LINK STRUCTURE
# "./" == "./www/"
# "./HTML" == "./www/HTML"
# library(shiny)


mainUI = fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "./STYLES/main.css")),
  h1(id = "title","MOVIE DATA ANALISYS"),
  p(id = "info","Fumagalli Damiano --- IBML 6 CFU"),
  p(id="c",a(id = "startLink","START PRESENTATION", href="./HTML/Presentation.html")),
  
  h3(id = "indexTitle","INDEX"),
  radioButtons("chosenAPP","CHOOSE THE APP",choiceNames = c("RECOMENDATION SYSTEM","MOVIELENS USER MAPS","OSCARS INTERACTIVE MAP"), choiceValues = c("RS","UM","OM")),
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


oscars_UI = fluidPage(
  h2("","OSCAR INTERACTIVE MAP"),
  radioButtons("license","CHOOSE THE AGE LIMITATION",choiceNames = c("ALL PEOPLE","OVER 10","OVER 13","OVER 17","UNRATED"), choiceValues = c("G","PG","PG-13","R","NA")),
  actionButton("sendLicense","SEND"),
  uiOutput("interactivePlot")
)



reccomendAPP_UI = fluidPage(
  h2(id = "","Recomendation System"),
  checkboxGroupInput("platform",label = "Choose your straming services", choiceNames = c("None","Amazon Prime Video","Disney +","Netflix"),choiceValues = c("none","amazon","disney","netflix")),
  radioButtons("movieType",label = "Choose the movie Type",choiceNames = c("Movie","TV-Shows"), choiceValues = c("M","T")),
  radioButtons("arrangeBy","Arrange BY",choices = c("year","duration","oscarNominees")),
  radioButtons("order","Select Order",choiceNames  = c("Ascending","Descending"), choiceValues = c("A","D")),
  textInput("age","INSERT YOUR AGE"),
  actionButton("print","SEND"),
  textOutput("printout"),
  tableOutput("outputType")
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
    } else if (input$chosenAPP == "OM") {
      oscars_UI
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
  
  # recomendation
   reccTable = eventReactive(input$print,{
      compiledList = list(platform = sort(input$platform),movieType = input$movieType, arrange = input$arrangeBy, order = input$order, age = input$age)
     reccomendAPP(compiledList)
   })
    output$outputType = renderTable({
      reccTable()
     })
    
    
    # OSCARS INTERACTIVE
    
    oscMap = eventReactive(input$sendLicense,{
      oscarMap(input$license)
    })
    
    output$interactivePlot = renderUI({
      ggplotly(oscMap())
    })
    
    
  }

# Run the application 
shinyApp(ui = mainUI, server = server)
