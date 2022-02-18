# INFO 201 AH
# P02: Exploratory Analysis
# GDP & Life Expectancy Chart

#library(maps)
#library(ggplot2)
world_data <- ggplot2::map_data('world')
world_data <- fortify(world_data)
head(world_data)

#Step 1: Load Data 
#setwd("~/Documents/Info201Code/final-project-starter-life-expectancy/source")
life_expectancy <- read.csv("LifeExpectancyData.csv")

#Get Formatted
gdp <- life_expectancy %>%
  filter(Year == max(Year)) %>%
  group_by(Country) %>%
  select(Country, GDP) 
life <- life_expectancy %>%
  filter(Year == max(Year)) %>%
  select(Country, Life.expectancy)

#Get map data for the world 
mapdata <- map_data("world") %>%
  rename(Country = region) 
mapdata$Country[ mapdata$Country == "USA" ] <- "United States"
mapdata$Country[ mapdata$Country == "Russia" ] <- "Russian Federation"
mapdata$Country[ mapdata$Country == "Iran" ] <- "Iran (Islamic Republic of)"
mapdata$Country[ mapdata$Country == "UK" ] <- "United Kingdom of Great Britain and Northern Ireland
"
gdp$Country[ gdp$Country == "United States of America"] <- "United States"
life$Country[ life$Country == "United States of America"] <- "United States"

#Combine gdp data frame with world data frame
mapdatagdp <- left_join(mapdata, gdp, by="Country")

#combine life data frame with world data frame 
mapdatalife <- left_join(mapdata, life, by="Country")

#Create map for GDP by country
mapgdp <- ggplot(mapdatagdp, aes(x = long, y = lat, group=group)) + 
  geom_polygon(aes(fill = GDP), color = "black")
mapgdp

#Create a map for life expectancy by country 
maplife <- ggplot(mapdatalife, aes(x = long, y = lat, group=group)) + 
  geom_polygon(aes(fill = Life.expectancy), color = "black")
maplife

