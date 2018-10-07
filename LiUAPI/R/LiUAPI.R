#' This is an API package 
#'  @name "Lab5 5 Package"
#'  
#'  This package intracts with Google API 
#'  
#'  @param  "place" is a character
#'          f in the key
#'  
#'  @return the long and lat
#'  
#'  @examples     
#'  latlong(Tehran)
#'  
#' @export
#'  
library(shiny)
library(magrittr)
library(leaflet)
library(httr)
library(jsonlite)
library(dplyr)
library(testthat)

#internal function to parse
parsing<-function(req)
{x<-content(req,"text")
if (identical(x,"")) warning ("HI AMIGO, THIS IS EMPTY! BE CAREFUL!")
fromJSON(x)}

latlong<-function(place,f)
{
  if(grepl("[[:punct:]]",place)) {stop("Error: Make sure your search is spelled correctly. Try adding a city, state, or zip code")}
  
  z<-list(address=place,key=f) #create the list of parameters I will send to google.
  
  place<-GET("https://maps.googleapis.com/maps/api/geocode/json",query=z) #this is the actual API connection.
  stop_for_status(place)
  parsed_place<-parsing(place) #I just parse what I receive.
  x<-parsed_place$results #now all my results are in x!
  x$formatted_address
  list("latitude and longitude"=x$geometry$location, "Complete name" = x$formatted_address)
  }



#' This function shows the distance between 2  places
#' 
#' @param numeric or character , enter two city name or particular place like 2 adrresses.
#' and the key to the API
#' @return it returns the distance betwen places by car.
#' 
#'  
#' 
#' 

distanfu<- function(place1,place2,f){
  if(grepl("[[:punct:]]",place1)) {stop("Error: Make sure your search is spelled correctly.what kinds of places are you looking for?and where?")}
  if(grepl("[[:punct:]]",place2)) {stop("Error: Make sure your search is spelled correctly.what kinds of places are you looking for?and where?")}
  if(place1 == place2){stop("The destenation needs to be diffrent from the origin")}
  z<-list(origin=place1,destination=place2,key=f)
  place<-GET("https://maps.googleapis.com/maps/api/directions/json",query=z) #this is the actual API connection.
  x<-parsing(place)
  unlist(x)
  x$routes$legs
  z<-x$routes$legs[[1]]
  z$distance
}





#' This function shows nearby places
#' 
#' @param numeric or character , enter a city name and a particular place like resturant or park.
#' and the key to the API
#' @return it returns nearby places by detail.
#' 
#' @example     
places <- function(input,f){
  if(grepl("[[:punct:]]",input)) {stop("Error: Make sure your search is spelled correctly.what kinds of places are you looking for?and where?")}
  
z<-list(input=input,key=f) #create the list of parameters I will send to google.
place<-GET("https://maps.googleapis.com/maps/api/place/textsearch/json?",query=z) #this is the actual API connection.
stop_for_status(place)
x<-parsing(place)
}

