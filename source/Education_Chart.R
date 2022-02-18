# INFO 201: AH 
# P02: Exploratory Analysis 
# Education and life expectancy Scatterplot 

#Loading Packages 
library(ggplot2)
#library(tidyverse)
library(lintr)

library(ggiraph)
#set working directory 
setwd("~/info201_code/final-project-starter-life-expectancy/source")

#Load data 
life_expectancy <- read.csv("LifeExpectancyData.csv")

#view data
#view(life_expectancy)

#Scatterplot
education_plot <- ggplot(data = life_expectancy) +
  geom_point(mapping = aes(x = Schooling , y = Life.expectancy), color = "blue") +
  labs(title = "Amount of Years of Schooling Versus Life Expectancy")  

