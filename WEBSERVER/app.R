# STRUTTURA LINK INTERNI
# "./" == "./www/"
# "./HTML" == "./www/HTML"
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "./STYLES/main.css")),
  p(id = "info","Fumagalli Damiano Matr: 157547   "),
  
  div(id = "images",
    h1(id = "title","MOVIE ANALISYS"),
    a(id = "startLink","START", href="./HTML/Presentazione.html"),
    br(),
    img(id = "flow" ,src = "./IMAGES/FLOWCHART.png"),
    h3("WORKFLOW"),
    img(src = "./IMAGES/TIMELINE.png"),
    img(src = "./IMAGES/TIMETABLE.png"),
  ),
  
  
  
)
server <- 
  function(input,output){
    re <- eventReactive(
      input$linkID,{"ciaoooo"})
    output$b <- renderText({ re()
    })
  }

# Run the application 
shinyApp(ui = ui, server = server)
