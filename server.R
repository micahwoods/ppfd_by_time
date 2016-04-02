
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library("shiny")
library("lubridate")

shinyServer(function(input, output) {

  output$text1 <- renderText({
    
    # gives first constant
    k1 <- (24*60)/pi  
    
    # the solar constant
    solar.constant <- 0.0820  
    
    # day of year as an integer
    day.of.year <- yday(input$date) 
    
    # inverse relative distance Earth-Sun, d-sub-r and solar declination
    inverse.distance <- 1 + 0.033 * cos(((2 * pi) / 365) * day.of.year)
    solar.declination <- 0.409 * sin((((2 * pi) / 365) * day.of.year) - 1.39)
    latitudeRadians <- (pi/180) * input$latitude 
    sunset.hour.angle <- acos(-tan(latitudeRadians) * tan(solar.declination))
   
    # Ra, extraterrestrial irradiance
    Ra <- ((k1 * solar.constant) * inverse.distance) *
      (sunset.hour.angle * sin(latitudeRadians) * sin(solar.declination) +
         cos(latitudeRadians) * cos(solar.declination) * sin(sunset.hour.angle))
    
    # Rs, solar irradiance, expressed in DLI units
    
    dli <- Ra * input$ab * 2.04
    
    # now calc on a minute by minute basis
    
    tHour <- input$hour
    
    tMinute <- input$minute
    
    t <- tHour + (tMinute / 60)
    
    t1 <- 1/60
    
    # the center of the time zone, in degrees west of Greenwich
    # so it is 360 - (15 * number of time zones)
    Lz <- input$Lz
    
    # longitude in degrees west of greenwich at the measurement point
    Lm <- input$Lm
    
    # latitude
    latM <- input$latitude
    
    Gsc <- 0.0820 
    
    # date <- ymd("2014-8-14")
    J <- day.of.year
    
    dr <- 1 + 0.033*cos(((2*pi)/365)* J)
    d <- 0.409*sin((((2*pi)/365)* J)-1.39)
    j <- (pi/180)*(latM) # convert latitude to radians
    
    b <- (2 * pi * (J - 81)) / 364
    
    Sc = 0.01645 * sin(2*b) - 0.1255 * cos(b) - 0.025 * sin(b)
    
    w <- (pi / 12) * ((t + 0.06667 * (Lz - Lm) + Sc) - 12)
    
    w1 <- w - ((pi * t1) / 24)
    w2 <- w + ((pi * t1) / 24)
    
    Ra <- ((12 * 60)/pi) * Gsc * dr * ((w2 - w1) *
                                                                       sin(j) * sin(d) +
                                                                       cos(j) * cos(d) * (sin(w2) -
                                                                                                                sin(w1)))
    
    
    no_cloud <- (input$ab)*Ra
    par <- no_cloud * 2.04
    
    # set as 0 rather than negative for dark hours
    calcPpfd <- ifelse(par < 0, 0, par * 10^6 / 60)
    
    # print the output
    ifelse(input$minute >= 10,
    paste("The expected PPFD in full sun at ", 
          input$hour, ":", input$minute, 
          " on ", input$date, " is ",
          formatC(calcPpfd, digits = 4),
          " and if there are no clouds on this day, the DLI at this location 
          is expected to be ",
          formatC(dli, digits = 3), ".", sep = ""),
    paste("The expected PPFD in full sun at ", 
          input$hour, ":", 0, input$minute, 
          " on ", input$date, " is ",
          formatC(calcPpfd, digits = 4),
          " and if there are no clouds on this day, the DLI at this location 
          is expected to be ",
          formatC(dli, digits = 3), ".", sep = "")
    )
    

  })

})
