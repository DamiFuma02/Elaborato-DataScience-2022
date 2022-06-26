# STRUTTURA LINK INTERNI
# "./" == "./www/"
# "./HTML" == "./www/HTML"
library(shiny)

# Define UI for application that draws a histogram
ui <- fluidPage(
  includeCSS("./STYLES/main.css"),
  img(src = "./IMAGES/FLOWCHART.png"),
  img(src = "./IMAGES/TIMELINE.png"),
  a(id = "startLink","START", href="./HTML/Presentazione.html"),
  textOutput("b")
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
