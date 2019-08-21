# Student ID: 23322004
# Student Username: wxtan4
# server.R
# Due data: 4 June 2018

shinyServer(function(input, output) {
  
# Loading the data, data would need to be in the same folder.
crypto_csv <- read.csv(file="crypto-markets(modified).csv",header=TRUE, sep=",")
interest_csv <- read.csv(file="local_search_trend.csv",header=TRUE, sep=",")

  # code for live data, kept for future development
  # live_search <- eventReactive(input$searchsubmit, {
  #   interest_table <- data.frame(gtrends(keyword=input$live_searchinput)[1])
  #   colnames(interest_table) <- c('date','hits','keyword','geo','gprop','category')
  #   interest_table$hits <- as.integer(gsub('<', '', interest_table$hits))
  #   interest_table
  # })

  
  # Creating the main plot
  output$mainPlot <- renderPlot({
    
    # Defining variables, these are the inputs from the UI.
    cryptocurrency <- input$cryptoinput 
    searchinput <- input$searchinput
    day_offset <- input$search_offset
    start_lim <- input$rangeslider[1]
    end_lim <- input$rangeslider[2]
    interest_offset <- input$interest_offset

    
    # code for live data, kept for future development
    # if (is.null(search_term)){
    # } else {
    #   interest_data <- live_search
    # }

    # This part is grouping the input data by using 'dplyr' library.
    # The date column will be converted using as.POSIXct for plotting x axis.
    interest_data <- interest_csv %>% filter(search_term==searchinput) %>% select('date','hits')
    interest_data$hits <- interest_data$hits + interest_offset
    interest_data$date <- as.POSIXct(interest_data$date,format="%m/%d/%Y")+(60*60*24*day_offset)
    crypto_data <- crypto_csv %>% filter(name==cryptocurrency) %>% select('date','scaled_close')
    crypto_data$date <- as.POSIXct(crypto_data$date)
    
    # This is variables for the date range, it is here instead of on top, is because it needs the grouped data.
    last_day <- tail(interest_data$date,1)
    first_day <- head(crypto_data$date,1)
    range_limt <- c(first_day+((last_day - first_day)/1000*start_lim),last_day-((last_day - first_day)/1000*(1000-end_lim)))
    
    # Creating the frame for the mainplot.
    # We use reassign method to make each steps clearer.
    main <- ggplot()+
      theme_classic()+
      theme(text=element_text(size=13),
            axis.title.x=element_blank(),
            axis.title.y=element_blank(),
            axis.text.x = element_text(angle = 45,hjust=1),
            plot.title=element_text(size=22, face="bold", color="black"),
            plot.subtitle=element_text(size=14, face="italic", color="black"),
            legend.justification=c(-0.1,0.7),
            legend.position = c(0,1),
            legend.text=element_text(size=9)
      )+
      labs(title=paste('Close Price of',cryptocurrency, 'vs Google Seacrch Trend of',searchinput),
           subtitle = 'Close price is % of changes from the beginning, and search trend is relative interest to the peak interest.')
    
    # Adding the curve for Cryptocurrency
    main <- main + geom_line(data=crypto_data,aes(date,scaled_close,colour='Close Price'),size=1.15)
    
    # Adding the curve for Google Search Trend, this must be after the cryptocurrency so that it can overlay on top of it.
    main <- main + geom_line(data=interest_data,aes(date,hits,colour='Search Interest'),size=1.15)
    
    # Scaling the data according to the date range, and changing the tick label into 3 months per break.
    main <- main + scale_x_datetime(date_labels ="%b'%y" ,date_breaks = '3 months',limits =range_limt)+
      scale_colour_manual('',breaks = c('Search Interest','Close Price'),values=c("dodgerblue4","lightpink1"))
    
    main
  })
  
  # Creating an interactive text according the input values of the Google Search Trend.
  output$step_one <- renderText({ 
    paste('Move the sliders below to shift the x axis and y axis for the "',input$searchinput,'" search trend, and try to align both curves together.')
    
  })
  # Creating an interactive text according the input values of the Cryptocurrency.
  output$shifted_text <- renderText({ 
    paste('If you match the curves, hooray!!! You have found a leading indicator for the "',input$cryptoinput,'" cryptocurrency with',input$search_offset,'days of leading time. 
          You can see that the search trend is now ahead of the cryptocurrency, so you can use the search trend to predict the future of the cryptocurrency, and this is what leading indicator is about.')

  })

})

