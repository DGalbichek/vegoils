library(shiny)
library(rmarkdown)
library(dplyr)
library(ggplot2)
library(gridExtra)

vegoils <- read.table("vegoils.txt", header=T, sep="\t")

shinyServer(
    function(input,output) {
        data <- reactive({
            dset<-vegoils[(vegoils$dat>=input$year[1])&(vegoils$dat<=input$year[2]),]
        })
        
        output$plot <- renderPlot({
            dset<-vegoils[(vegoils$dat>=input$year[1])&(vegoils$dat<=input$year[2]),]
            plot(dset$dat, rep(100,length(dset$dat)), type='l', xlim=c(input$year[1],input$year[2]), 
                 ylim=c(0.0,300.0), xlab='', ylab='')
            par(new=T)
            if ("oli" %in% input$checkGroup) {
                plot(dset$dat, dset$oli, type='l', xlim=c(input$year[1],input$year[2]), 
                    ylim=c(0.0,300.0), col=2, xlab='', ylab='')
                par(new=T)
            }
            if ("pal" %in% input$checkGroup) {
                plot(dset$dat, dset$pal, type='l', xlim=c(input$year[1],input$year[2]), 
                     ylim=c(0.0,300.0), col=3, xlab='', ylab='')
                par(new=T)
            }
            if ("rap" %in% input$checkGroup) {
                plot(dset$dat, dset$rap, type='l', xlim=c(input$year[1],input$year[2]), 
                     ylim=c(0.0,300.0), col=4, xlab='', ylab='')
                par(new=T)
            }
            if ("soy" %in% input$checkGroup) {
                plot(dset$dat, dset$soy, type='l', xlim=c(input$year[1],input$year[2]), 
                     ylim=c(0.0,300.0), col=5, xlab='', ylab='')
                par(new=T)
            }
            if ("sun" %in% input$checkGroup) {
                plot(dset$dat, dset$sun, type='l', xlim=c(input$year[1],input$year[2]), 
                     ylim=c(0.0,300.0), col=6, xlab='', ylab='')
                par(new=T)
            }
            if ("pop" %in% input$checkGroup) {
                plot(dset$dat, dset$pop, type='l', xlim=c(input$year[1],input$year[2]), 
                     ylim=c(0.0,300.0), col=7, xlab='', ylab='')
                par(new=T)
            }
            if ("con" %in% input$checkGroup) {
                plot(dset$dat, dset$con, type='l', xlim=c(input$year[1],input$year[2]), 
                     ylim=c(0.0,300.0), col=8, xlab='', ylab='')
                par(new=T)
            }
            par(new=F)
        })
        
        output$summary <- renderPrint({
            dset<-vegoils[(vegoils$dat>=input$year[1])&(vegoils$dat<=input$year[2]),]
            if (length(input$checkGroup)>1) {lapply(dset[,input$checkGroup], function(x) {
                t<-c(summary(x), summary(x)[6]/summary(x)[1]*100); names(t)[7]="Change"; return(t)})}
            else if (length(input$checkGroup)==1) {
                summary(dset[,input$checkGroup])
               
            }
        })
        
        output$table <- renderTable({
            dset<-vegoils[(vegoils$dat>=input$year[1])&(vegoils$dat<=input$year[2]),]
            data.frame(x=dset[,input$checkGroup])
        })

    }
)