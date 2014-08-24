library(shiny)
library(datasets)

data(mtcars)

train <- train(mpg ~ cyl+wt+hp, data=mtcars, method="lm")

mpgPred <- function(mydata) {
    predict(train,newdata=mydata)
}

shinyServer(
    function(input, output) {
        output$wtIn <- renderPrint({input$wt})
        output$hpIn <- renderPrint({input$hp})
        output$cylIn <- renderPrint({input$cyl})
        
        output$wtHist <- renderPlot({
            hist(mtcars$mpg, xlab='Miles per gallon (mpg)', col='lightblue',main='Histogram')
            mydata <- data.frame(wt = input$wt, hp = input$hp, cyl = input$cyl)
            mu <- mpgPred (mydata)
            lines(c(mu, mu), c(0, 20),col="red",lwd=5)
            mse <- mean((mtcars$mpg - mu)^2)
            text(30, 12, paste("mu = ", round(mu, 2)))
            text(30, 10, paste("MSE = ", round(mse, 2)))
        })
    }    
) 