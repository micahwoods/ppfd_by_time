
# Let user put in latitude, then calculate Ra
# let user put in mean temperature, low, high
# let user pick crop coefficient
# then print the reference ET and the ETk



library(shiny)

shinyUI(fluidPage(
  
  # Application title
  titlePanel("PPFD and DLI by time, day, latitude, and longitude."),
  withMathJax(),

  # Sidebar to input necessary data
  
  verticalLayout(
   
      dateInput("date", "Date:"),
      
      numericInput("hour", "Hour", 12,
                   0, 23, 1),
      
      numericInput("minute", "Minute", 30,
                   0, 59, 1),

      numericInput("latitude",
                  "Latitude in degrees N or S of the equator",
                  min = -70,
                  max = 70,
                  value = 13.4,
                  step = 0.01),
      
      numericInput("Lm",
                   "Longitude degrees W of Greenwich",
                   min = 0,
                   max = 359.99,
                   value = 259.4,
                   step = 0.01),
      
      numericInput("Lz",
                   "Longitude at center of time zone, degrees W of Greenwich",
                   min = 0,
                   max = 359.99,
                   value = 255,
                   step = 0.01),
      
      numericInput("ab", "transmittance",
                              0.75, min = 0, max = 1, step = 0.01),
      
        
    
    
    # Show the output
   
      h3(textOutput("text1")),
    
    # explain what this is
    hr(),
    helpText(HTML(paste("PPFD is photosynthetic photon flux density in units of µmol photons m",
                   tags$sup("-2"), " s", tags$sup("-1"), " and DLI
                   is daily light integral in units of mol m",
                    tags$sup("-2"), " d", tags$sup("-1"), ".", sep = ""))),
    
      helpText(HTML(paste("For more information about this calculator, 
                    see the code on ",
                        a("GitHub.",
                          href = "https://github.com/micahwoods/ppfd_by_time"),
                        sep = "")))
      
    )
  )
)



