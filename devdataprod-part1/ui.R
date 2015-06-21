library(shiny)

shinyUI(
  navbarPage("attitude dataset",
             tabPanel("Detail",
                      h2("Chatterjee-Price Attitude Data"),
                      hr(),
                      h3("Description"),
                      helpText("The data was extracted from questionnaires of approximately 35 employees for each 30 (randomly selected) departments,",
                               " and comprises overall rating and 6 different attitude characteristics."),
                      h3("Format"),
                      p("A data frame with 30 observations on 7 variables."),
                      
                      p("   Y    rating     Overall rating"),
                      p("  X[1]  complaints	Handling of employee complaints"),
                      p("  X[2]  privileges	Does not allow special privileges"),
                      p("  X[3]  learning	  Opportunity to learn"),
                      p("  X[4]  raises	    Raises based on performance"),
                      p("  X[5]  critical	  Too critical"),
                      p("  X[6]  advance	  Advancement"),
                      
                      h3("Help on use"),
                      p("In order to use this app, select the variables for which the linear model will be constructed, or the variable to see the boxplot of the rating vs the selected variable."),
                      
                      h3("Source"),
                      
                      p("Chatterjee, S. and Price, B. (1977) Regression Analysis by Example. New York: Wiley. (Section 3.7, p.68ff of 2nd ed.(1991).)")
             ),
             tabPanel("Analysis",
                      fluidPage(
                        titlePanel("The relationship between variables and overall rating"),
                        sidebarLayout(
                          sidebarPanel(
                            helpText("Select variables for the linear model."),
                            checkboxInput('complaints', 'Complaints'),
                            checkboxInput('privileges', 'Privileges'),
                            checkboxInput('learning', 'Learning'),
                            checkboxInput('raises', 'Raises'),
                            checkboxInput('critical', 'Critical'),
                            checkboxInput('advance', 'Advancement'),
                            helpText("Select the variable for the box plot."),
                            selectInput("variable", "Variable:",
                                        c("Complaints" = "complaints",
                                          "Privileges" = "privileges",
                                          "Learning" = "learning",
                                          "Raises" = "raises",
                                          "Critical" = "critical",
                                          "Advancement" = "advance"
                                        ))
                          ),
                          
                          mainPanel(
                            tabsetPanel(type = "tabs", 
                                        tabPanel("Regression model", 
                                                 h3(textOutput("caption")),
                                                 plotOutput("ratingPlot"),
                                                 verbatimTextOutput("fit")
                                        ),
                                        tabPanel("BoxPlot",
                                                 h3(textOutput("captionBox")),
                                                 plotOutput("ratingBoxPlot"))
                            )
                          )
                        )
                      )
             ),
             tabPanel("SourceCode",
                      p("devdataprod"),
                      a("https://github.com/lmsv-mx123/devdataprod/")
             ),
             tabPanel("Report",
                      a("http://lmsv-mx123.github.io/devdataprod/Report/DocDevDataProdProj.html"),
                      hr(),
                      tags$iframe(src="DocDevDataProdProj.html", 
                                  width="100%", height=600, frameborder=0, 
                                  seamless=NA)
             )
  )
)