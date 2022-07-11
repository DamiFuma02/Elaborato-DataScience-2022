# STRUTTURA LINK INTERNI
# "./" == "./www/"
# "./HTML" == "./www/HTML"
library(shiny)
library(dplyr)

# alla compilazione vengono 
# introdotti tutti i file presenti nella cartella R/


mainUI = fluidPage(
  a(id = "startLink","START", href="./HTML/Presentazione.html")
)


# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "./STYLES/main.css")),
  p(id = "info","Fumagalli Damiano Matr: 157547   "),
  h1(id="tit",amazon$title[1]),
  div(id="start",
      h1(id = "title","MOVIE ANALISYS"),
      a(id = "startLink","START", href="./HTML/Presentazione.html"),
      br(),
  ),
  
  
  div(id = "images",
    
    img(id = "flow" ,src = "./IMAGES/FLOWCHART.png"),
    img(id = "flowW" ,src = "./IMAGES/flow.png"),
    h3("WORKFLOW"),
    img(src = "./IMAGES/TIMELINE.png"),
    img(src = "./IMAGES/TIMETABLE.png"),
  ),
)

# APP per genere in funzione di occupation per MOVIELENS
MLgenOccUI = fluidPage(
  selectInput("occType","Scegli il lavoro",workTable$workType),
  actionButton("genOcc","Mostra genere preferito"),
  textOutput("genreOut")
)


genreOcc = function(occType){
  occID = workTable[workTable$workType == occType,]$workID
  mov = left_join(left_join(users %>% filter(Occupation == occID),ratings, by = "userID"),movies,by = "movieID")
  prec = 0
  gen = ""
  for (i in 1:length(genreTable$genre)){
    a = nrow(mov %>% filter(grepl(genreTable$genre[i],Genres)))
    if (a > prec) {
      prec = a
      gen = genreTable$genre[i]
    }
  }
  return(gen)
}




server <-  function(input,output){
    #GENRE(WORKTYPE)
    genOcc = eventReactive( input$genOcc, {genreOcc(input$occType)} )
    output$genreOut = renderText({genOcc()})
  }

# Run the application 
shinyApp(ui = mainUI, server = server)
