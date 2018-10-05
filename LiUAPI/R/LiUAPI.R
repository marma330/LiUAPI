library(shiny)
library(magrittr)
library(leaflet)
library(httr)
library(jsonlite)

#internal function to parse
parsing<-function(req)
{x<-content(req,"text")
if (identical(x,"")) warning ("HI AMIGO, THIS IS EMPTY! BE CAREFUL!")
fromJSON(x)}


place<-"Thorapadi"  #place input!
f <- "AIzaSyAGdetT_wO2o2Q6LfHFVmEw7yxFnvVpCbo"

latlong<-function(place,f)
{
  z<-list(address=place,key=f) #create the list of parameters I will send to google.
  
  place<-GET("https://maps.googleapis.com/maps/api/geocode/json",query=z) #this is the actual API connection.
  
  stop_for_status(place)
  
  
  parsed_place<-parsing(place) #I just parse what I receive.
  x<-parsed_place$results #now all my results are in x!
  x$formatted_address
  list("latitude and longitude"=x$geometry$location, "Complete name" = x$formatted_address)
}

#example we did together
#place1<-"rydsvagen 246"
#place2<-"linkoping university"
#z<-list(origin=place1,destination=place2,key="")
#place<-GET("https://maps.googleapis.com/maps/api/directions/json",query=z) #this is the actual API connection.
#x<-parsing(place)
#unlist(x)
#x$routes$legs
#z<-x$routes$legs[[1]]
#z$distance


z<-list(input="museums in linkoping",key="") #create the list of parameters I will send to google.
place<-GET("https://maps.googleapis.com/maps/api/place/textsearch/json?",query=z) #this is the actual API connection.
x<-parsing(place)

