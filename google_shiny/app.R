#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(magrittr)
library(leaflet)
library(httr)
library(jsonlite)

# Define UI for application
ui <- fluidPage(
  
  # Application title
  titlePanel("Google API"),
  
  # Sidebar with a text input and action button
  sidebarLayout(
    sidebarPanel(
      h3(textInput(inputId = "Start",label = "Enter the place name")),
      actionButton(inputId = "Find",label = "Find exact location")
    ),
    
    # Show a map
    mainPanel(
      tags$style("#Location {font-size:20px;
                 color:darkblue;
                 display:block; }"),     
      div(style="text-align:center;
          box-shadow: 10px 10px 5px #888888;
          width:300px;
          height:300px;
          padding-top:100px;
          position:relative;",
          textOutput(outputId = "Location")),
      div(style="text-align:center;
          width:1000px;
          height:1000px;
          padding-top:100px;
          position:relative;",
          leafletOutput(outputId = "mymap"))
      )
      )
  )

# Define server logic required to output the map and text
server <- function(input, output) {
  observeEvent(input$Find,{
    
    library(httr)
    library(jsonlite)
    
    var <- input$Start
    
    parsing<-function(req)
    {x<-content(req,"text")
    if (identical(x,"")) warning ("HI AMIGO, THIS IS EMPTY! BE CAREFUL!")
    fromJSON(x)}
    
    
    z<-list(address=var,key="") #create the list of parameters I will send to google.
    
    var<-GET("https://maps.googleapis.com/maps/api/geocode/json",query=z) #this is the actual API connection.
    
    stop_for_status(var)
    
    
    parsed_var<-parsing(var) #I just parse what I receive.
    x<-parsed_var$results #now all my results are in x!
    x$formatted_address
    x1 <- list("latitude and longitude"=x$geometry$location, "Complete name" = x$formatted_address)
    
    
    lat <- as.numeric(unname(x1[[1]][1]))
    lng <- as.numeric(unname(x1[[1]][2]))
    loc <- as.character(unname(x1[[2]][1]))
    x2 <- list(lat,lng)
    
    o1<-paste("Latitude:",lat,sep="")
    o2<-paste("Longitude:",lng,sep="")
    o3<-paste("Location:",loc,sep="")
    
    output$Location <- renderText(paste(c(o1,o2,o3)))
    
    output$mymap <- renderLeaflet({
      x2 %>% leaflet() %>%
        addTiles() %>%
        addMarkers(lng = ~lng,
                   lat = ~lat, popup="Location you was searching for")
      
      
    })
  })
}

# Run the application 
shinyApp(ui = ui, server = server)