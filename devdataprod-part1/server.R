library(shiny)
library(datasets)

ratingData <- attitude

shinyServer(function(input, output) {
  
  formulaText <- reactive({
    paste("rating ~", input$variable)
  })
  
  formulaTextPoint <- reactive({
    p <- "";
    if(input$complaints) {
      paste(p, "+", "complaints")
    }
    if(input$privileges) {
      paste(p, "+", "privileges")
    }
    if(input$learning) {
      paste(p, "+", "learning")
    }
    if(input$raises) {
      paste(p, "+", "raises")
    }
    if(input$critical) {
      paste(p, "+", "critical")
    }
    if(input$advance) {
      paste(p, "+", "advance")
    }
    if(p == "") {
      p <- "."
    }
    else {
      p <- substr(p,3,nchar(p))
    }
    paste("rating ~", p)
  })
  
  fit <- reactive({
    lm(as.formula(formulaTextPoint()), data=ratingData)
  })
  
  output$caption <- renderText({
    formulaText()
  })
  
  output$ratingBoxPlot <- renderPlot({
    boxplot(as.formula(formulaText()), 
            data = ratingData,
            outline = input$outliers)
  })
  
  output$fit <- renderPrint({
    summary(fit())
  })
  
  output$ratingPlot <- renderPlot({
    with(ratingData, {
      plot(as.formula(formulaTextPoint()))
      abline(fit(), col=2)
    })
  })
  
})