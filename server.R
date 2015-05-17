library(dplyr)
library(reshape2) # for tidy data
library(shiny)
library(ggplot2) # plots

shinyServer(function(input, output){
  
  state = reactive({
    state = input$state
  })
  my_color=reactive({
    my_color = input$color
  })
  population = read.csv("population.csv")
  
  output$data = renderTable({
    population
  })
  output$str = renderPrint({
    str(population)
  })
  output$documentation = renderUI({
    str1="<br>The application provides information about the Australian indigenous population, 
          by State / Territory, 1971 to 2006."
    str2 = "The population can be displayed by state/territory or for the whole of Australia. 
Use the drop down list on the left-hand side to switch the plot between Australia and its states and territories"
    str3 = "You can also select the color of the line plots"
    str4 = "The raw data was obtained from The Australian Bureau of Statistics web site"
    str5 = "<hr>"
    str6 = "             (c) Antony Mapfumo, May 2015"
    HTML(paste(str1, str2, str3, str4, str5, str6, sep='<br>'))
  })
  
    output$myplot = renderPlot({
      data = melt(population, id="YEAR")
      colnames(data)= c("YEAR", "STATE", "POPULATION")
      states = c("NSW", "QLD", "WA", "TAS","SA", "ACT","VIC","NT","AUSTRALIA")
      data_subset = subset(data, STATE==states[as.integer(state())])
      ggplot(data_subset, aes(x=YEAR, y=POPULATION/1000))+geom_point(size=6, color="brown")+
        geom_line(lwd=2, colour=my_color())+ylab("(Population) x 1000")+geom_smooth(method=lm)
    })
  output$multiplot = renderPlot({
    data = melt(population, id="YEAR")
    colnames(data)= c("YEAR", "STATE", "POPULATION")
    ggplot(data, aes(x=YEAR, y=POPULATION/1000, color=STATE))+geom_line()+geom_point()+ylab("(Population) x 1000")+theme_bw()
  })
  }  
)
