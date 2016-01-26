
# data resource is U.S. Department of State Air Quality Monitoring Program
# download from here: http://www.stateair.net/web/historical/1/1.html

# read data in year 2008 to 2015
bj2008<- read.csv("data/Beijing_2008_HourlyPM2.5_created20140325.csv", 
                  header = TRUE, skip = 3, fileEncoding="latin1")

bj2009<- read.csv("data/Beijing_2009_HourlyPM25_created20140709.csv",
                  header = TRUE, skip = 3, fileEncoding="latin1")

bj2010<- read.csv("data/Beijing_2010_HourlyPM25_created20140709.csv",
                  header = TRUE, skip = 3, fileEncoding="latin1")

bj2011<- read.csv("data/Beijing_2011_HourlyPM25_created20140709.csv",
                  header = TRUE, skip = 3, fileEncoding="latin1")

bj2012<- read.csv("data/Beijing_2012_HourlyPM2.5_created20140325.csv",
                  header = TRUE, skip = 3, fileEncoding="latin1")

bj2013<- read.csv("data/Beijing_2013_HourlyPM2.5_created20140325.csv",
                  header = TRUE, skip = 3, fileEncoding="latin1")

bj2014<- read.csv("data/Beijing_2014_HourlyPM25_created20150203.csv",
                  header = TRUE, skip = 3, fileEncoding="latin1")

bj2015<- read.csv("data/Beijing_2015_HourlyPM25_created20160104.csv",
                  header = TRUE, skip = 3, fileEncoding="latin1")

# create a function to process the data
dataProcess<- function(df){
      # keep 5 columns interested: Year, Month, Day, Hour, Value
      df<- df[,4:8]
      # missing values are coded as -999
      df[df$Value == -999,] <- NA
      # remove NAs
      df<- df[!is.na(df), ]
      
      # get the average values for every day by averaging the observations
      # in all hours that day
      df.day<- aggregate(Value ~ Month + Day, data = df, FUN = mean)
      
      # get the average values for every month by averaging the averages
      # in all days that month
      df.mon<- aggregate(Value ~ Month, data = df.day, FUN = mean)
      
      # return a data frame of monthly averages including the year
      return(data.frame(Year = rep(df$Year[1], nrow(df.mon)), df.mon))
}

# bind the monthly averages in all the years together
bjData<- rbind(dataProcess(bj2008), dataProcess(bj2009), 
                    dataProcess(bj2010), dataProcess(bj2011),
                    dataProcess(bj2012), dataProcess(bj2013),
                    dataProcess(bj2014), dataProcess(bj2015))

# get the average values for every year by averaging the averages
# in all months that year
df.year<- aggregate(Value ~ Year, data = bjData, FUN= mean)

library(ggplot2)

shinyServer(
      function(input, output, session) {
            
            output$bjPlot <- renderPlot({
                  # subset the data in the year selected in ui
                  bjDataSelected<- bjData[bjData$Year == input$rYear, ]
                  
                  # if annual trend radio button selected, plot the annual data
                  if(input$spanId == 1) {
                        qplot(x = Year, y = Value, data = df.year,
                              xlab = "Year", 
                              ylab = "Daily Average PM 2.5 (µg/m³)",
                              main = "Annual Trend of Daily Average PM 2.5
                              in Beijing",
                              geom = c("point", "line")) 
                  }
                  
                  # if monthly trend radio button selected, plot the monthly
                  # data of the selected year
                  else if(input$spanId == 2) {
                        qplot(x = Month, y = Value, 
                              xlim = c(0,12),
                              data = bjDataSelected,
                              xlab = paste("Month in ", input$rYear),
                              ylab = "Daily Average PM 2.5 (µg/m³)",
                              main = paste("Monthly Trend of Daily Average
                                           PM 2.5 in Beijing in ", input$rYear),
                              geom = c("point", "line"))
                        }
                  
                  })
            })
