require(dplyr)
setwd("~/Documents/Biogeography")
infant_data <- read.csv("~/Documents/Biogeography/RatesDeaths_AllIndicators.csv")

median_data <- infant_data %>%
  select(Country, Median) %>%
  distinct()

long_data <- infant_data %>%
  pivot_longer(
    cols = c("U5MR", "IMR", "NMR", "Under_five_deaths", "Infant_deaths", "Neonatal_deaths"),
    names_to = "type",
    values_to = "value"
  ) %>%
  mutate(
    country = Country,
    year = Year,
    type = factor(type, levels = c("U5MR", "IMR", "NMR", "Under_five_deaths", "Infant_deaths", "Neonatal_deaths"))
  ) %>%
  select(country, year, type, value)
