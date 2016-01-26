

shinyUI(fluidPage(
      titlePanel("Beijing PM 2.5 in History"),
      
      sidebarLayout(
            sidebarPanel(
                  p("Air Pollution in Beijing attracts world-wide attention
                    these years."),
                  p("Take a look at the PM 2.5 historical data in Beijing."),
                  p("In China, the yearly and daily average limit of PM 2.5 is
                    35 µg/m3 and 75 µg/m3 respectively. Whether the values exceed
                    the standards or not is colored in the plot."),
                  
                  # radio button to choose annual or monthly trend to present
                  # set the default to "Annual"
                  radioButtons("spanId", label = h4("Which Kind of Trend"), 
                               choices = list("Annual" = 1,
                                              "Monthly" = 2),
                               selected = 1),
                  p(),
                  
                  # radio button to choose monthly trend in which year to present
                  radioButtons("rYear", label = h4("In Which Year"),
                               choices = list("2008" = 2008, 
                                              "2009" = 2009, 
                                              "2010" = 2010,
                                              "2011" = 2011,
                                              "2012" = 2012,
                                              "2013" = 2013,
                                              "2014" = 2014,
                                              "2015" = 2015), 
                               selected = NULL),
                  p(),
                  p(),
                  
                  p("Data source: U.S. Department of State Air Quality
                    Monitoring Program"),
                  p("Please note that these data are not fully verified or validated.")
                  
            ),
            
            # show the output plot
            mainPanel(plotOutput("bjPlot"))
)))

