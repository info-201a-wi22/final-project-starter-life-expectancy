# INFO 201 AH
# P02: Exploratory Analysis
# Summary Information

# Load Packages
library("dplyr")

# Load csv file
life_expectancy <- read.csv("https://raw.githubusercontent.com/info-201a-wi22/final-project-starter-life-expectancy/main/data/LifeExpectancyData.csv")

# Create list of summary information
summary_info <- list()
summary_info$country <- life_expectancy$Country

# Working with Vaccination

# Total vaccinations of the population
summary_info$total_vaccination_hep <- life_expectancy$Hepatitis.B * life_expectancy$Population
summary_info$total_vaccination_polio <- life_expectancy$Polio * life_expectancy$Population
summary_info$total_vaccination_diphtheria <- life_expectancy$Diphtheria * life_expectancy$Population

# Combined average percentage of total vaccination percentages
summary_info$vaccination_percentage <- (life_expectancy$Hepatitis.B + life_expectancy$Polio + life_expectancy$Diphtheria) / 3

# Ratio of vaccination and infant mortality
summary_info$vaccine_ratio <- (summary_info$vaccination_percentage / life_expectancy$infant.deaths)


# Working with GDP

# Amount of expenditure on health from GDP in USD
summary_info$health_expenditure <- life_expectancy$GDP * life_expectancy$percentage.expenditure


# Working with Education

# Percentage of school years vs life expectancy
summary_info$education_ratio <- (life_expectancy$Schooling / life_expectancy$Life.expectancy) * 100

