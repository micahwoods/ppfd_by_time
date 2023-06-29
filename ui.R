
# Let user put in latitude, longitude, time zone longitude,
# time of day, and day of year
# then use Angstrom equation to estimate Rs from Ra and convert to PAR

shinyUI(fluidPage(
  
  tags$head(includeHTML((
    "google_analytics.html"
  ))),
  
  # Application title
  titlePanel("PPFD and DLI by time, day, latitude, and longitude."),
  ## withMathJax(),
  HTML(paste("See more about light and photosynthetically active radiation (PAR) on the ",
          a("ATC website",
            href = "https://www.asianturfgrass.com/tag/light/"),
          ".",
          sep = "")),

  # Sidebar to input necessary data
  
  verticalLayout(
   
      dateInput("date", "Date:"),
      
      numericInput("hour", "Hour", 12,
                   0, 23, 1),
      
      numericInput("minute", "Minute", lubridate::minute(lubridate::now()),
                   0, 59, 1),

      numericInput("latitude",
                  "Latitude in degrees N or S of the equator",
                  min = -66.6,
                  max = 66.6,
                  value = 13.4,
                  step = 0.01),
      
      numericInput("Lm",
                   "Longitude degrees E or W of Greenwich",
                   min = -179.99,
                   max = 179.99,
                   value = 100.5,
                   step = 0.01),
      
      # numericInput("Lz",
      #              "Longitude at center of time zone, degrees W of Greenwich",
      #              min = 0,
      #              max = 359.99,
      #              value = 255,
      #              step = 0.01),
      
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
    
    helpText(HTML(paste("This app calculates the PPFD and DLI for any location between 66° N and 66° S using the Ångström equation."))),
    
      helpText(HTML(paste("For more information about this calculator, 
                    bug reports, and feature requests, see the code on ",
                        a("GitHub.",
                          href = "https://github.com/micahwoods/ppfd_by_time"),
                        " You can find PAR, light, and shade information at the PACE Turf and ATC websites. This is version 0.1.3 of the ",
                        code("ppfd_by_time"),
                        " app, last updated by Micah Woods on 2023-06-29.",
                        sep = ""))),
    br(),
    a(href = "https://www.paceturf.org", 
      img(src = "pace.png", width = 300, height = 41)),
    br(),
    a(href = "https://www.asianturfgrass.com", 
      img(src = "atc_logo_no_white.png", height = 137, width = 300)),
    br()
      
    )
  )
)



