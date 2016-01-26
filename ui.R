

shinyUI(fluidPage(
      titlePanel("Beijing PM 2.5 in History"),
      
      sidebarLayout(
            sidebarPanel(
                  p("Air Pollution in China attracts world-wide attention
                    in recent years."),
                  p("Take a look at the PM 2.5 historical data observed 
                    in Beijing using the right plot."),
                  p("China sets the annual and daily average limit of PM 2.5 as
                    35 µg/m3 and 75 µg/m3 respectively. Whether the observations
                    exceed these standards is colored in the plot."),
                  
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
                               selected = NULL)
            ),
            
            # show the output plot
            mainPanel(plotOutput("bjPlot"),
                      
                      p(),
                      p(),
                      
                      tags$div(
                            class = "header",
                            checked = NA,
                            tags$p("Data source: U.S. Department of State Air Quality
                    Monitoring Program"),
                            tags$a(href="http://www.stateair.net/web/historical/1/1.html",
                                   "download here")
                      ),
                      
                      p(),
                      p(),
                      
                      tags$div(
                            class = "header",
                            checked = NA,
                            tags$p("know more about the data: "),
                            tags$a(href="http://www.stateair.net/web/assets/USDOS_AQDataFilesFactSheet.pdf",
                                   "Data Files Fact Sheet")
                      ),
                      
                      
                      p(),
                      p(),
                      
                      p("Please note that these data are not fully verified or validated.")
            )
)))

