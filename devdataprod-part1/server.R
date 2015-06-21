library(shiny)
library(datasets)

ratingData <- attitude

shinyServer(function(input, output) {
  
  formulaText <- reactive({
    paste("rating ~", input$variable)
  })
  
  formulaTextPoint <- reactive({
    p <- ""
    if(input$complaints) {
      p <- paste(p,"complaints",sep="+")
    }
    if(input$privileges) {
      p <- paste(p,"privileges",sep="+")
    }
    if(input$learning) {
      p <- paste(p,"learning",sep="+")
    }
    if(input$raises) {
      p <- paste(p,"raises",sep="+")
    }
    if(input$critical) {
      p <- paste(p,"critical",sep="+")
    }
    if(input$advance) {
      p <- paste(p,"advance",sep="+")
    }
    if(nchar(p) > 0) {
      p <- substr(p,2,nchar(p))
    }
    else {
      p <- paste(p,"complaints+privileges+learning+raises+critical+advance")
    }
    paste("rating ~ ", p)
  })
  
  fit <- reactive({
    lm(as.formula(formulaTextPoint()),data=ratingData)
  })
  
  output$caption <- renderText({
    formulaTextPoint()
  })
  
  output$captionBox <- renderText({
    formulaText()
  })
  
  output$fit <- renderPrint({
    summary(fit())
  })
  
  output$ratingPlot <- renderPlot({
    with(ratingData, {
      par(mfrow=c(2, 2))
      plot(lm(as.formula(formulaTextPoint()),data=ratingData))
      abline(fit(), col=2)
    })
  })
  
  output$ratingBoxPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = ratingData,
            xlab = input$variable,
            ylab = "rating")
  })
  
})