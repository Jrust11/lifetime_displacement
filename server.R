library(shiny)
library(leaflet)
library(pracma)

server <- function(input, output) {
  

  lon <- 0
  lat <- 0
  
  Entry <- observeEvent(input$button, { 
    
    
    name = input$address
    
    src_url <- "https://nominatim.openstreetmap.org/search.php?q="
    
    name <- str_replace_all(name, "[ ,]", "+")
    
    
    addr <- paste((name), collapse  = "+")
    
    requests <- paste0(src_url, addr, "&format=geojson")
    
    res <- GET(requests)
    
    content(res, as="text") %>% fromJSON(flatten=FALSE) -> out
    
    lon <- out$features$geometry$coordinates[[1]][1]
    
    lat <- out$features$geometry$coordinates[[1]][2]
    
    
    df <- data.frame(longitude = c(input$long,lon),latitude = c(input$lat,lat))
  
    
    output$map <- renderLeaflet({
      leaflet(df) %>% 
        addTiles() %>% addCircleMarkers(radius = 25) %>% 
        addPolylines(data = df, lng = ~longitude, lat = ~latitude) %>% 
        addProviderTiles("Esri.WorldImagery")
    })
    
    
    
    current_location = c(input$long,input$lat)
    birth_location = c(lon,lat)
    total_d = (haversine(current_location, birth_location)*0.6213712)
    
  
    
    output$Title <- renderPrint({
      total_d
    })
    
    
    
  })
  
  
  
  'output$lon_now <- renderPrint({
      lon
    })
    output$lat_now <- renderPrint({
      lat
    })'
  
  'output$long <- renderPrint({
    input$long
  })
  
  output$lat <- renderPrint({
    input$lat
  })'
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}









