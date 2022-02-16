# INFO 201: Project Pt 2
# Vaccinations vs. Infant Mortality Rate:
# Density Chart

# Loading Packages 
library(ggplot2)
library(tidyverse)
library(dplyr)

# Set working directory 
setwd("~/Documents/Info201code/final-project-starter-life-expectancy/source")

# Load data from csv file
life_expectancy <- read.csv("./LifeExpectancyData.csv")

# Isolate related data and find the average per country
vaccinations_data <- life_expectancy %>%
  select(Country, Hepatitis.B, infant.deaths) %>%
  group_by(Country) %>%
  summarize(Hepatitis.B = mean(Hepatitis.B, na.rm = TRUE), 
            infant.deaths = mean(infant.deaths))

# Density Comparison Chart
ggplot(vaccinations_data) +
  geom_density(aes(x = Hepatitis.B, fill = "HepB_Coverage"), alpha = 0.5) +
  geom_density(aes(x = infant.deaths, fill = "Infant_Mortality"), alpha = 0.5) +
  labs(title = "Hepatitis B Immunization Coverage vs. Infant Mortality Rates", 
       x = "Population Percentage", y = "Density", fill = "Data Type") +
  xlim(0, 100)

