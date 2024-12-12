# abanks045.github.io
- Research Question
-- How does elevation affect tree species richness in forests?

- This question aims to find the difference in tree species richness as elevation gradients increase and decrease.

- Background and Significance
-- The relationship between elevation and tree species richness is a fundamental topic, as elevation acts as a key environmental gradient that influences climate, temperature, and habitats. Species richness tends to vary with elevation due to changes in conditions such as resource availability, temperature, and precipitation. Understanding this relationship is crucial for predicting how forests will respond to climate change, as species may migrate to higher elevations in search of suitable conditions, leading to shifts in biodiversity patterns. Knowledge of how elevation affects tree diversity helps inform conservation strategies, as certain elevation zones may harbor higher species richness and therefore require protection. This research can also provide insights into forest dynamics, ecosystem resilience, and land-use planning, especially in areas subject to human disturbance or environmental stress.

- Data
-- Using current FIA data to compare tree species richness with elevation gradients, key graphs and maps were created to better understand the relationship.
``` 
library(dplyr)
## 
## Attaching package: 'dplyr'
## The following objects are masked from 'package:stats':
## 
##     filter, lag
## The following objects are masked from 'package:base':
## 
##     intersect, setdiff, setequal, union
library(ggplot2)

tree <- readRDS("~/Documents/Biogeography/FIA_tree_master1-1.RDS")
# grouping of species richness with elev
species_richness_by_elevation <- tree %>%
  filter(!is.na(SPCD), !is.na(ELEV)) %>%
  group_by(ELEV) %>%
  summarize(species_richness = n_distinct(SPCD)) %>%
  ungroup()
# grouping of data by lat, lon, and elev
species_richness_map_data <- tree %>%
  filter(!is.na(SPCD), !is.na(ELEV), !is.na(LAT), !is.na(LON)) %>%
  group_by(LAT, LON, ELEV) %>%
  summarize(species_richness = n_distinct(SPCD)) %>%
  ungroup()
## `summarise()` has grouped output by 'LAT', 'LON'. You can override using the
## `.groups` argument.
# polynomial regression line shown to display spcd and elev relationship
ggplot(species_richness_by_elevation, aes(x = ELEV, y = species_richness)) +
  geom_point(alpha = 0.6) +
  geom_smooth(method = "lm", formula = y ~ poly(x, 2), se = FALSE, color = "blue") +
  labs(title = "Species Richness vs. Elevation",
       x = "Elevation",
       y = "Species Richness") +
  theme_minimal()

```
![image](https://github.com/user-attachments/assets/75f04fa2-9eb3-4683-bf02-fc1c7052bb28)

```
# elevation map displaying high and low elevation gradients
ggplot(species_richness_map_data, aes(x = LON, y = LAT, color = ELEV)) +
  geom_point(alpha = 0.6, size = 1) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Elevation",
       x = "Longitude",
       y = "Latitude",
       color = "Elevation") +
  theme_minimal() +
  coord_quickmap()
```
![image](https://github.com/user-attachments/assets/18b3a496-dad3-40e3-8a31-a48cd1bc4172)

```
# species richness map displaying high and low levels of species richness
ggplot(species_richness_map_data, aes(x = LON, y = LAT, color = species_richness)) +
  geom_point(alpha = 0.6, size = 1) +
  scale_color_gradient(low = "blue", high = "red") +
  labs(title = "Species Richness",
       x = "Longitude",
       y = "Latitude",
       color = "Species Richness") +
  theme_minimal() +
  coord_quickmap()
```
![image](https://github.com/user-attachments/assets/ec6b3eca-7c0e-4470-a090-157808898852)

```
species_richness_by_elevation <- species_richness_by_elevation %>%
  mutate(elevation = cut(ELEV, breaks = seq(0, 3000, by = 500), 
                             labels = c("0-500", "500-1000", "1000-1500", "1500-2000", "2000-2500", "2500-3000")))

bin_summary <- species_richness_by_elevation %>%
  group_by(elevation) %>%
  summarize(avg_species_richness = mean(species_richness), .groups = "drop")

# bar graph displaying species richness with elevation bands
ggplot(bin_summary, aes(x = elevation, y = avg_species_richness, fill = elevation)) +
  geom_bar(stat = "identity") +
  labs(title = "Average Species Richness by Elevation", x = "Elevation", y = "Avg Species Richness") +
  theme_minimal()
```
![image](https://github.com/user-attachments/assets/b8905461-efd7-4678-b56e-c60b91b8d4b8)

- Conclusion
-- Tree species richness follows distinct patterns regarding elevation gradients with low to mid elevations consisting of higher levels of species richness, and high elevations consisting of lower levels.

- Improvements
-- Compare current findings with past FIA data to see if climate change has had an impact on species richness. This can conclude if there is an ongoing trend of species richness increasing at higher levels of elevation as time has past, and it can help predict possible future climbs in species richness among certain locations. This can also be used to study species range in higher elevations. As one contributing factor to high species range at higher elevation is the lack of competition. This leads to the hypothesis that as species richness increases in higher elevations, certain species ranges can decrease due to increased competition.
