# shiny server
library("shiny")
library(tidyverse)
library(maps)
library(ggplot2)
# Create a shiny server that creates a scatterplot. 

# It should use an `input` with features: `x_var`, `y_var`, `color`, and `size`
# Save the result of `renderPlot` to output$scatter

# Reads in raw data for csv
life_expectancy <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-life-expectancy/main/data/LifeExpectancyData.csv")

# Creates blank theme for map plot
blank_theme <- theme_bw() +
  theme(
    axis.line = element_blank(),        
    axis.text = element_blank(),        
    axis.ticks = element_blank(),       
    axis.title = element_blank(),       
    plot.background = element_blank(),  
    panel.grid.major = element_blank(), 
    panel.grid.minor = element_blank(), 
    panel.border = element_blank()      
  )

# Creates scatterplot of schooling and life expectancy
server <- function(input, output) {
  output$education_output <- renderPlotly({
    education_plot <- ggplot(data = life_expectancy) +
      geom_point(mapping = aes(x = Schooling , y = Life.expectancy), color = input$color_input) +
      labs(
        x = "Schooling",
        y = "Life Expectancy",
      ) +
      scale_x_continuous(limits = input$restrict)
    return(education_plot)
  })
  
  # Creates a overlaying density plot of the chosen vaccine and infant mortality
  output$vaccination_plot <- renderPlotly({
    vaccinations_data <- life_expectancy %>%
      select(Country, Hepatitis.B, Polio, Diphtheria, infant.deaths) %>%
      group_by(Country) %>%
      summarize(Hepatitis.B = mean(Hepatitis.B, na.rm = TRUE), 
                Polio = mean(Polio, na.rm = TRUE),
                Diphtheria = mean(Diphtheria, na.rm = TRUE),
                infant.deaths = mean(infant.deaths, na.rm = TRUE)) 
    vaccinations_data[is.na(vaccinations_data)] <- 0
    vaccinations_data[] <- lapply(vaccinations_data, function(x) ifelse(x > 100, 100, x))
    
    vaccination_plot <- ggplot(vaccinations_data) +
      geom_density(aes_string(x = input$vaccine, fill = "input$vaccine"), alpha = 0.6) +
      geom_density(aes(x = infant.deaths, fill = "Infant Mortality"), alpha = 0.6) +
      labs(x = "Population Percentage", y = "Density", fill = "Data Type") +
      scale_fill_manual(values = c("Hepatitis.B" = "#8DB996", "Polio" = "#8DB996", 
                                   "Diphtheria" = "#8DB996", "Infant Mortality" = "#8B95C9"))
  })
  
# Creates map plot
  output$maplife <- renderPlotly({
    world_data <- ggplot2::map_data('world')
    world_data <- fortify(world_data)
    head(world_data)
      
    # Get formatted
    life <- life_expectancy %>%
      select(Country, Life.expectancy, Year) 
    #Get map data for the world 
    mapdata <- map_data("world") %>%
      rename(Country = region) 
    
    mapdata$Country[ mapdata$Country == "USA" ] <- "United States"
    mapdata$Country[ mapdata$Country == "Russia" ] <- "Russian Federation"
    mapdata$Country[ mapdata$Country == "Iran" ] <- "Iran (Islamic Republic of)"
    mapdata$Country[ mapdata$Country == "UK" ] <- "United Kingdom of Great Britain and Northern Ireland"
    # gdp$Country[ gdp$Country == "United States of America"] <- "United States"
    life$Country[ life$Country == "United States of America"] <- "United States"
    #combine life data frame with world data frame 
    mapdatalife <- left_join(mapdata, life, by="Country")

    mapdatalife <- mapdatalife %>%
      filter(Year == input$slider1) 
      
    #Create a map for life expectancy by country 
    maplife <- ggplot(mapdatalife, aes(x = long, y = lat, group=group)) + 
      geom_polygon(aes(fill = Life.expectancy), color = "white") +
      scale_fill_continuous(limits = c(0, max(mapdatalife$Life.expectancy)), 
                            low = "#ffffff", high = "#7D5BA6") +
      blank_theme
    maplife
    return(maplife)
  })
  output$value <- renderPrint({
    input$slider1
  })
    
  # Calculates min life expectancy
  output$minlifeexpectancyus <- renderText({
    minlifeexpectancyus <- life_expectancy %>%
      select(Country, Life.expectancy, Year) %>%
      filter(Country == "United States of America") %>%
      filter(Life.expectancy == min(Life.expectancy)) %>%
      pull(Year)
    return(minlifeexpectancyus)
  })
  
    # Calculates max life expectancy
  output$maxlifeexpectancyus <- renderText({
    maxlifeexpectancyus <- life_expectancy %>%
      select(Country, Life.expectancy, Year) %>%
      filter(Country == "United States of America") %>%
      filter(Life.expectancy == max(Life.expectancy)) %>%
      pull(Year)
    return(maxlifeexpectancyus)
  })
   
  # Calculates the average vaccine coverage around the world for 1-year olds
  output$avg_vaccine_coverage <- renderText({
    avg_vaccine_coverage <- life_expectancy %>%
      summarize(Hepatitis.B = mean(Hepatitis.B, na.rm = TRUE),
                Polio = mean(Polio, na.rm = TRUE),
                Diphtheria = mean(Diphtheria, na.rm = TRUE)) %>%
      mutate(vaccine_coverage = (Hepatitis.B + Polio + Diphtheria) / 3) %>%
      mutate_if(is.numeric, round, digits = 2) %>%
      pull(vaccine_coverage)
    paste0(avg_vaccine_coverage, "%")
  })
  
  # Calculates the average infant mortality around the world
  output$avg_infant_deaths <- renderText({
    avg_infant_deaths <- life_expectancy %>%
      summarize(infant.deaths = mean(infant.deaths, na.rm = TRUE)) %>%
      pull(infant.deaths)
    round(avg_infant_deaths)
  })
    
  #Lowest Schooling Years
  output$min_schooling <- renderText({
    min_schooling <- life_expectancy %>%
      select(Country, Life.expectancy, Year, Schooling) %>%
      filter(Year == max(Year)) %>%
      drop_na %>%
      filter(Schooling == min(Schooling)) %>%
      pull(Schooling)
    return(min_schooling)
  })
  
  # highest schooling years 
  output$max_schooling <- renderText({
    max_schooling <- life_expectancy %>%
      select(Country, Life.expectancy, Year, Schooling) %>%
      filter(Year == max(Year)) %>%
      drop_na %>%
      filter(Schooling == max(Schooling)) %>%
      pull(Schooling)
    return(max_schooling)
  })
  
  #Country with highest schoolings years
  output$high_schooling <- renderText({
    high_country_schooling <- life_expectancy %>%
      select(Country, Life.expectancy, Year, Schooling) %>%
      filter(Year == max(Year)) %>%
      drop_na %>%
      filter(Schooling == max(Schooling)) %>%
      pull(Country)
    return(high_country_schooling)
  })
  
  #Country with lowest schooling years
  output$low_schooling <- renderText({
    low_country_schooling <- life_expectancy %>%
      select(Country, Life.expectancy, Year, Schooling) %>%
      filter(Year == max(Year)) %>%
      drop_na () %>%
      filter(Schooling == min(Schooling)) %>%
      pull(Country)
    return(low_country_schooling)
  })
  
    
    
}
