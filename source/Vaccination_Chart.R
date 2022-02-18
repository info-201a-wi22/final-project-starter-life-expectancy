# INFO 201 AH
# P02: Exploratory Analysis
# Vaccinations vs. Infant Mortality Rate:
# Density Chart

# Loading Packages 

# Set working directory 

# Load data from csv file
life_expectancy <- read.csv("./LifeExpectancyData.csv")

# Isolate related data and find the average per country
vaccinations_data <- life_expectancy %>%
  select(Country, Hepatitis.B, infant.deaths) %>%
  group_by(Country) %>%
  summarize(Hepatitis.B = mean(Hepatitis.B, na.rm = TRUE), 
            infant.deaths = mean(infant.deaths))

# Density Comparison Chart
vaccination_plot <- ggplot(vaccinations_data) +
  geom_density(aes(x = Hepatitis.B, fill = "HepB Vaccination Coverage"), alpha = 0.5) +
  geom_density(aes(x = infant.deaths, fill = "Infant Mortality Rate"), alpha = 0.5) +
  labs(title = "Hepatitis B Immunization Coverage vs. Infant Mortality Rates", 
       x = "Population Percentage", y = "Density", fill = "Data Type") +
  xlim(0, 100)

vaccination_plot
