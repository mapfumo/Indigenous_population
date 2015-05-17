# Load the shiny package
library(shiny)
library(shinythemes)
shinyUI(fluidPage(theme = shinytheme("united"),
  titlePanel(title=" Indigenous population, by State / Territory, 1971 to 2006"),
  sidebarLayout(
    sidebarPanel((""),
                 selectInput("state","Select state", 
                             choices=c("NSW"=1, "QLD"=2, "WA"=3, "TAS"=4,"SA"=5, "ACT"=6,"VIC"=7, "NT"=8,"AUSTRALIA"=9),selected=9), 
                 br(),
                 radioButtons("color", "Plot line color", 
                              choices=c("Green", "Red", "Yellow", "steelblue"),selected="Green")
    ),
    mainPanel(
      tabsetPanel(type="tab",
                  tabPanel("Individual Plot", plotOutput("myplot")),
                  tabPanel("Multi-State", plotOutput("multiplot")),
                  tabPanel("Data", tableOutput("data")),
                  tabPanel("Structure", verbatimTextOutput("str")),
                  tabPanel("Documentation", htmlOutput("documentation"))
      )  
    )
  )
)
)









