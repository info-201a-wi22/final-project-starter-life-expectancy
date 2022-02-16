# Summary Information

# Load Packages
library("dplyr")

# Load csv file
life_expectancy <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-life-expectancy/main/data/LifeExpectancyData.csv")
View(life_expectancy)

# Remove NA values
na.omit(life_expectancy)

summary_info <- list()


# Working with Vaccination

# Combined percentage of vaccination percentages
summary_info$vaccination_percentage <- life_expectancy$Hepatitis.B + life_expectancy$Polio + life_expectancy$Diphtheria

# Ratio of vaccination and infant mortality
summary_info$vaccine_ratio <- (summary_info$vaccination_percentage / life_expectancy$infant.deaths)


# Working with GDP

# Amount of expenditure on health from GDP in USD
summary_info$health_expenditure <- life_expectancy$GDP * life_expectancy$percentage.expenditure

# Ratio of expenditure and population
summary_info$expenditure_ratio <- life_expectancy$Population / summary_info$health_expenditure


# Working with Education

# Ratio of school years and life expectancy
summary_info$education_ratio <- life_expectancy$Schooling / life_expectancy$Life.expectancy

View(summary_info)

