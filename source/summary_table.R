# INFO 201 AH
# P02: Exploratory Analysis
# Summary Information Table

# Load packages
library("dplyr")

# Source the summary information
source("summary_info.R")

# Create table of summary information
sum_table <- data.frame(summary_info)

# Group all data from the same country into the average of the different years
sum_table <- sum_table %>%
  group_by(country) %>%
  summarize(vaccination_percentage = mean(vaccination_percentage, na.rm = TRUE), 
            total_vaccination_hep = mean(total_vaccination_hep, na.rm = TRUE), 
            total_vaccination_polio = mean(total_vaccination_polio, na.rm = TRUE), 
            total_vaccination_diphtheria = mean(total_vaccination_diphtheria, na.rm = TRUE), 
            vaccine_ratio = mean(vaccine_ratio, na.rm = TRUE), 
            health_expenditure = mean(health_expenditure, na.rm = TRUE), 
            education_ratio = mean(education_ratio, na.rm = TRUE))

# Take all Inf values and remove them
is.na(sum_table) <- sapply(sum_table, is.infinite)
sum_table <- na.omit(sum_table)

# Round numbers to two decimal places and remove scientific notation
sum_table <- sum_table %>%
  mutate_if(is.numeric,
            round,
            digits = 2) %>%
  mutate_if(is.numeric,
            format,
            scientific = FALSE)

# Rename column names
sum_table <- sum_table %>%
  rename("Country" = country, 
         "Average Vaccination Percentage" = vaccination_percentage, 
         "Total Hepatitis B Vaccinations" = total_vaccination_hep, 
         "Total Polio Vaccinations" = total_vaccination_polio, 
         "Total Diphtheria" = total_vaccination_diphtheria, 
         "Vaccine and Infant Mortality Ratio" = vaccine_ratio, 
         "Expenditure on Health from GDP in USD" = health_expenditure, 
         "Percentage of Schooling Years vs Life Expectancy" = education_ratio)

