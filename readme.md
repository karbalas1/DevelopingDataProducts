Shiny Application: Playing With 'mtcars' Data Model
====================================

**Background:**  
R has a "datasets" package that comes with some out of the box data models that can be used for data analysis. In this little shinyApplication, I am using the `mtcars` dataset.  

**server.r**
Using this dataset, I built a training model using the "lm" method (linear model) with `mpg` as the outcome and `wt`, `cyl` and `hp` as predictors.  
  
Based on the slider input selections for the predictors `wt`, `cyl` and `hp`, the model will be be used to predict the `mpg`. Then the `server.r` returns the plot with the predicted `mpg` indicated as a red line in the historgram along with the `MSE` and predicted `mpg` as displayed text values with up to 2 decimal places.  
  
```r  
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
```    
  
**ui.r**  
The ui interface of the shinyApplication displays the sliders as input for `wt`, `cyl` and `hp`. The selection is reactive and the plot displays as the selection changes. Based on the combination of the 3 input slider values, the selections are sent to the `server.r` to process the predicted `mpg` and plot to be rendered. Once the `server.r` processed the input selections, control is sent back to `ui.r` to display the plot and also to display the selected input values.   
```r  
library(shiny)  
  
shinyUI(  
    pageWithSidebar(  
        headerPanel("Playing With 'mtcars' Data Model"),  
        sidebarPanel(  
            sliderInput('wt', 'Guess at the weight(wt)',value = 3, min = 1, max = 5.5, step = 0.5,),  
            sliderInput('cyl', 'Guess for the cylinders(cyl)',value = 4, min = 2, max = 8, step = 2,),  
            sliderInput('hp', 'Guess at the horsepower(hp)',value = 150, min = 50, max = 300, step = 50,)  
        ),  
        mainPanel(  
            h3("Results of prediction"),  
            h4("Weight (wt) selected: "),  
            verbatimTextOutput("wtIn"),  
            h4("Cylinders (cyl) selected: "),  
            verbatimTextOutput("cylIn"),  
            h4("HorsePower (hp) selected: "),  
            verbatimTextOutput("hpIn"),  
            plotOutput('wtHist')  
        )  
    )  
)  
```  
  
**Note:**   
It is a very simple application that uses a simple linear data model based on the dataset `mtcars`. You should be able to play around with the application by sliding the input sliders for `wt`, `cyl` and `hp` and be able to notice the impact of the selection on `mpg` on the motor vehicles.  
  
You should be able to notice and interpret easily from the plot the following observations:  
1) an increase or decrease in `wt` will decrease or increase the `mpg` of the vehicles respectively.  
2) an increase or decrease in `hp` will decrease or increase the `mpg` of the vehicles respectively.  
3) an increase or decrease in `cyl` will decrease or increase the `mpg` of the vehicles respectively.   
  
Try plotting the following to see the relation between predictors `wt`, `cyl` and `hp` and outcome `mpg`.  
  
```r   
library(caret)  
featurePlot(x=mtcars[,"mpg"],y=mtcars[,c("wt","cyl","hp")])  
```  
