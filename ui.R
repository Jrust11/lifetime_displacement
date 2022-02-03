library(shiny)
library(rsconnect)
library(shiny)
library(dplyr)
library(RJSONIO)
library(stringr)
library(rvest)
library(jsonlite)
library(httr)
library(leaflet)

Sys.setenv(TZ='America/New_York')


ui <- function(req)fluidPage(
  
  
  
  tags$script('
      $(document).ready(function () {
        navigator.geolocation.getCurrentPosition(onSuccess, onError);
              
        function onError (err) {
          Shiny.onInputChange("geolocation", false);
        }
              
        function onSuccess (position) {
          setTimeout(function () {
            var coords = position.coords;
            console.log(coords.latitude + ", " + coords.longitude);
            Shiny.onInputChange("geolocation", true);
            Shiny.onInputChange("lat", coords.latitude);
            Shiny.onInputChange("long", coords.longitude);
          }, 1100)
        }
      });
              '),
  
  
  titlePanel("Lifetime Displacement"),
  
  
  sidebarLayout(
    sidebarPanel(
      
      textInput(inputId = "address", "Address of Birthplace"),
      actionButton(inputId = "button", label = "Click to Log"),
      

    ),
    
    
    mainPanel(
      
      
      verbatimTextOutput("Title"),
      
      #verbatimTextOutput('lon_now'),
      
      #verbatimTextOutput('lat_now'),
      
      #verbatimTextOutput("long"),
      
      #verbatimTextOutput("lat"),
    
      
      leafletOutput("map", width = "100%" ,height="500")
      
    )
    
  )
)





