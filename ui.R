library(shiny)
library(rmarkdown)
library(dplyr)
library(ggplot2)
library(gridExtra)

shinyUI(fluidPage(
    sidebarLayout(
        sidebarPanel(
            h4("Series:"),
            p("Choose from the following series to compare how they change over time. (All are global total indices with base 2000.)"),
            checkboxGroupInput("checkGroup", label="",
                choices = list(
                    "Olive oil consumption" = "oli",
                    "Palm oil consumption" = "pal",
                    "Rapeseed oil consumption" = "rap",
                    "Soyabean oil consumption" = "soy",
                    "Sunflowerseed oil consumption" = "sun",
                    "Population" = "pop",
                    "Vegetable oil consumption per capita" = "con"),
                selected = c("pop","con")),
            h4("Year range:"),
            p("Choose the year interval you'd like to observe data from."),
            sliderInput("year", label="", min = 1973, max = 2016, value = c(1973, 2016)),
            h4("Tabs:"),
            p("The Plot tab (shown by default) displays graphical comparison of the selected series. The list of the data points can be seen on the Table tab. Basic numerical analysis is found on the Summary tab."),
            h4("Sources:"),
            p("The data is just a rough indication, there's some misalignment due to how differently the sources quote. Seasons don't match calendar years but for simplicity they are treated as equals to the calendar year they have the most in common with."),
            p("[", a("USDA PSD Online", href="https://apps.fas.usda.gov/psdonline/psdQuery.aspx", target="_blank"),
            " ] [ ",a("geohive.com", href="http://www.geohive.com/earth/his_history3.aspx", target="_blank"), " ]")
        ),
        mainPanel(
            titlePanel("Vegetable oils we eat"),
            tabsetPanel(type = "tabs", 
                        tabPanel("Plot", plotOutput("plot")), 
                        tabPanel("Table", tableOutput("table")),
                        tabPanel("Summary", verbatimTextOutput("summary"))
            )
        )
    )    
))