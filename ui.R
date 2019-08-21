# Student ID: 23322004
# Student Username: wxtan4
# ui.R
# Due data: 4 June 2018

# Imorting libraries
library(dplyr)
library(ggplot2)
#library(gtrendsR)


shinyUI(fluidPage(
  
  # Changing the outlook of the application, for more details on the design please refer to the written report.
  tags$style(HTML(".irs-single, .irs-to, .irs-from {background:transparent;color:black;}",
                  ".irs-slider {border:0px;top: 21px; width: 25px; height: 15px;}",
                  ".irs-min {background:transparent;}",
                  ".irs-max {background:transparent;}",
                  ".irs-bar-edge {background: #A8A8A8; border:0px; }", 
                  ".irs-bar {background: #A8A8A8; border-bottom:0px; border-top:0px;}",
                  ".irs-line {background: transparent;}",
                  ".irs-grid-pol {display: none;}",
                  ".irs-grid-text {display: none;}",
                  ".well {background-color:transparent;}",
                  ".well {border-width:0px;}",
                  ".well {padding:0px;}",
                  ".well {-webkit-box-shadow: none; -moz-box-shadow: none;box-shadow: none;}",
                  "a {font-size:18px;}",
                  "body {font-family: roboto,helvetica,arial;}")),
  

  # Using fluidrow style to create left and right margin, as many websites look this way.
  fluidRow(
    
    # Writing the title using 'tags$div', so that it can be easily customized.
    column(8, offset = 2,
           tags$div(HTML("</br><p style=\"font-size:30px;line-height:1.5; font-weight:bold; text-align:center;\">
                          An Attempt to Understand the Leading Indicator through Cryptocurrency using Interactive Visualization</p>
                         <p style=\"font-size:16px; text-align:center; font-style:italic;\">by Wei Xin, Tan</p>"))),
  
    # Writing the introduction using 'tags$div', so that it can be easily customized.
    column(8, offset = 2,
           tags$div(HTML("<p style=\"font-size:20px; line-height:1.4; text-align:justify; color:#444444;\">
                   &nbsp;&nbsp;&nbsp;&nbsp<font color=\"darkred\">Welcome visitor!</font> So you are interested in finding out the leading indicator in cryptocurrency.
                   First, we need to understand the terminology of leading indicator. Leading indicator is when a market is having
                   a leading trend of another market. For example, land prices and housing prices, when the price of land increases,
                   the price of houses will increase too, but the price doesn't reflect instantaneously, it follows behind. Therefore,
                   land market is said to be the leading indicator of housing price. However, in real world this
                   might not be the case, it's just an example. So now let's try to find out what could be the leading indicator for 
                   cryptocurrency.</p>")))
    ),
  
  # A few break lines to create spaces before the main plot.
  br(),
  br(),
  br(),
  
  fluidRow(
    
    # Creating the right sidepanel, and the step by step guide will be included in here.
    # There are also 2 interative texts, 2 slider inputs and a few text descriptions.
    column(2,offset = 1,wellPanel(
      
      tags$div(HTML("<p style=\"font-size:20px ; font-weight:bold; color:#ffaa00; \">Please Start From Here &darr;</p>")),
      
      tags$div(HTML("<p style=\"font-size:16px ; font-weight:bold;\">Step 1:</p>")),
      
      textOutput("step_one"),
      
      sliderInput("search_offset", "Y",min = 0, max = 1000, value = 0),
      
      sliderInput("interest_offset", "X",min = -50, max = 50, value = 0),
      
      textOutput("shifted_text"),
      
      tags$div(HTML("</br><p>Great, now go to the right panel, and  change the cryptocurrency and google search trend, see if you can find one that matches.</p>"))
    )),
    
    # Displaying the main plot, and extending the height to make it bigger.
    column(6, plotOutput("mainPlot",height = "600")),
    
    # Creating the right sidepanel.
    # There are 1 single slider, 1 range slider, 2 select boxes and a few text descriptions.
    column(2,wellPanel(
      tags$div(HTML("<p style=\"font-size:16px ; font-weight:bold;\">Step 2:</p>")),
      
      tags$div(HTML("<p style=\"font-size:15px ;\">Select cryptocurrency and google search trend that you wish to analye.</p>")),
      
      selectInput("cryptoinput","Cryptocurrency:", 
                  c("Example",
                    'Bitcoin',
                    'Novacoin',
                    'Ethereum',
                    'Ripple',
                    'Litecoin',
                    'EOS',"TRON",
                    "Bitcoin Cash",
                    'Namecoin','Peercoin')),
      
      
      selectInput("searchinput","Google Search Trend:", 
                  c("Example",
                    'Apple',
                    'Artificial intelligence',
                    'Black market',
                    'Blockchain',
                    'Cannabis',
                    'Jake Paul',
                    'Monash University',
                    'Quantum computing',
                    "Online shopping",
                    "Vitruvian Man")),
      
      tags$div(HTML("</br><p style=\"font-size:16px ; font-weight:bold;\">Step 3(Optional):</p>")),
      
      tags$div(HTML("<p style=\"font-size:15px ;\">Select a data range, some leading indicator
                    can only be seen in a very small time frame.</p>")),
      
      
      sliderInput("rangeslider", label = "Date Range", min = 0, 
                  max = 1000, value = c(0, 1000)),
      
      tags$div(HTML("<p style=\"font-size:20px ; font-weight:bold; color:#ffaa00; \"> &larr;Now go back to Step 1</p>"))
      
      
      # code for live data, kept for future development
      #textInput("live_searchinput","Live Google Search Trend (Beta):",value = "Example"),
      #actionButton(inputId = "searchsubmit",label = "Submit")

    )),
    
    # Writing the conclusion using 'tags$div', so that it can be easily customized. 
    column(8, offset = 2,
           br(),
           br(),
           br(),
           tags$div(HTML("<p style=\"font-size:20px; line-height:1.4;text-align:justify; color:#444444;\">
                   So did you find anything interesting? Well, if you didn't find any is okay, we all know that the 
                   price of any market is driven by the supply and demand, and the supply and demand can come from 
                   various markets, trying to predict it with a single factor is little unrealistic. That’s why forecasting 
                   in financial market remains a challenging task even with today’s technology, or else, everyone would be rich. 
                   However, the key take away here is you understand the concept of leading indicator. Thank you and have a great day!&#9786;</p>"))),
    
    # This part is adding hyperlinks to create a more information section
    column(8, offset = 2,
           tags$div(HTML("</br></br>
                         <b><p style=\"font-size:20px\">To understand more about certain terminology, please visit below website:</p></b>
                         <a href=\"https://www.investopedia.com/terms/c/closingprice.asp\">Close Price Definition from Investopedia</a></br>
                         <a href=\"https://www.investopedia.com/terms/l/leadingindicator.asp\">Leading indicator Definition from Investopedia</a></br>
                         <a href=\"https://en.wikipedia.org/wiki/Cryptocurrency\">Cryptocurrency on Wikipedia</a></br>
                         <a href=\"https://trends.google.com/trends/\">More on Google Trend</a>
                         </br></br></br>"))
           
  ))
  
  
))

