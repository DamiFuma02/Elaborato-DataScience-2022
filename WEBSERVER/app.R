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
  h1(id = "title","CINEMATOGRAPHIC ANALYSIS"),
  p(id = "info","Fumagalli Damiano --- IBML 6 CFU"),
  a(id = "startLink","START PRESENTATION", href="./HTML/Presentation.html"),
  
  h3(id = "indexTitle","INDEX"),
  radioButtons("chosenAPP","CHOOSE THE APP",choiceNames = c("Reccomendation System","genreOccAPP","genreMAP"), choiceValues = c("RS","GO","GM")),
  actionButton("invia","INVIA"),
  uiOutput("outUI")
)

genreMap_UI = fluidPage(
  
  selectInput("genre","seleziona il genere",MLGenres$genre),
  actionButton("start","INVIA"),
  plotOutput("plotOut")
)



reccomendAPP_UI = fluidPage(
  h2(id = "","Reccomendation System"),
  checkboxGroupInput("platform",label = "Choose your straming services", choiceNames = c("Amazon Prime Video","Disney +","Netflix"),choiceValues = c("amazon","disney","netflix")),
  checkboxGroupInput("movieType",label = "Choose the movie Type",choiceNames = c("Movie","TV-Shows","Both"), choiceValues = c("M","T","B")),
  selectInput("arrangeBy","Arrange BY",choices = c("Year","duration")),
  radioButtons("order","Select Order",choiceNames  = c("Ascending","Descending"), choiceValues = c("A","D")),
  actionButton("print","SEND"),
  textOutput("printout"),
  tableOutput("printTable")
)








# APP per genere in funzione di occupation per MOVIELENS
genreOccAPP_UI = fluidPage(
  selectInput("occType","Scegli il lavoro",workTable$workType),
  actionButton("genOcc","Mostra genere preferito"),
  textOutput("genreOut")
)







server <-  function(input,output){
  # CHOOSE UI
  appUI = eventReactive(input$invia,{
    if (input$chosenAPP == "RS") {
      reccomendAPP_UI  
    } else if (input$chosenAPP == "GO") {
      genreOccAPP_UI
    } else {
      genreMap_UI
    }
  })
  output$outUI = renderUI( { appUI() } )
  
  # genreMAP
  genreMAP = eventReactive(input$start,{
    userMapByGenre(input$genre)
  })
  output$plotOut = renderPlot({
    genreMAP()
  })
  
  # reccomendation
   reccTable = eventReactive(input$print,{
      compiledList = list(platform = sort(input$platform),movieType = input$movieType, arrange = input$arrangeBy, order = input$order)
     reccomendAPP(compiledList)
   })
    output$printTable = renderTable({
      reccTable()
     })
    
    # genre Occupation
    genreOCC = eventReactive(input$genOcc,{
      genreOcc(input$occType)
    })
    
    output$genreOut = renderText({
      genreOCC()
    })
    
    
    
    
    
   
    
  }

# Run the application 
shinyApp(ui = mainUI, server = server)
