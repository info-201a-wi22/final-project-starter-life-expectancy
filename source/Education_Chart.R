# INFO 201: Project Pt 2
# File 2 
# Education and life expectancy 
# Scatterplot 

#Loading Packages 
library(ggplot2)
library(tidyverse)

#set working directory 
setwd("~/info201_code/final-project-starter-life-expectancy/source")

#Load data 
life_expectancy <- read.csv("LifeExpectancyData.csv")

#view data
ggplot(data = life_expectancy)

#Scatterplot
ggplot(data = life_expectancy) +
  geom_point(mapping = aes(x = Schooling , y = Life.expectancy), color = "blue")
