library(shiny)

shinyUI(
    pageWithSidebar(
        headerPanel("Playing With 'mtcars' Data Model"),
        sidebarPanel(
            p("With this application, you can observe the impact of weight, number of cylinders and horse power of a vehicle on it's fuel efficiency in miles per gallon"),
            p("Notice that increasing or decreasing any of these will decrease or increase the miles per gallon respectively. The overall change in miles per gallon depends on the combined changes to all the 3 predictors."),
            p("Enough said, now play with the sliders and observe the mpg predicted 'mu' on the histogram..."),
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
