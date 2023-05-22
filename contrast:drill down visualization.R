library(dplyr)
library(stringr)
library(ggplot2)
library(tidyr)
library(tidyverse)

# scatter plot showing contrast between different regions population density
# versus their carbon emissions

final_df <- read.csv("final_df.csv")
regions_df <- read.csv("USAregions copy.csv")



final_with_reg_df <- left_join(final_df, regions_df, by = c("State" = "Name"))

# x axis should be population density
# y axis should be carbon emissions
# color should be by each region

# scatter_contrast <- 
#   ggplot(data = final_with_reg_df, aes(x = Resident.Population.Density, 
#          y = MtCO2e.level, color = Region.Name)) +
#   geom_point() +
#   labs(x = "Population Density per State", 
#        y = "CO2 concentration, measured in metric tons of carbon dioxide equivalent", 
#        color = "US Regions")

# first plot - violin - showing regions on the x axis and carbon emissions on the y
# legend is color = regions
# second plot is a bar plot showing different population densities per region
# will have to make a new df with regions and average densities

violin_regions <- 
  ggplot(data = final_with_reg_df, aes(x = Region.Name, y = MtCO2e.level, 
                                      color = Region.Name)) +
  geom_violin() +
  labs(x = "US Regions", 
       y = "CO2 concentration, measured in metric tons of carbon dioxide equivalent", 
       color = "United States Regions") + 
  theme_minimal()

region_pop_df <- summarize(final_with_reg_df, Resident.Population.Density, Region.Name)

bar_regions_pop <- 
  ggplot(data = region_pop_df, aes(x = Region.Name, y = Resident.Population.Density,
                                   color = Region.Name)) +
  geom_bar(stat = 'identity', fill = NA) +
  labs(x = "US Regions", 
       y = "Mean Population Density per region; averaged over years 1990-2020",
       color = "United States Regions") +
  theme_minimal()


#DRILL DOWN
#scatter plot specifying washington


scatter_wa <- 
  ggplot(data = final_with_reg_df, aes(x = Resident.Population.Density, 
         y = MtCO2e.level)) + 
  geom_point(col = ifelse(final_with_reg_df$State == "Washington", "chartreuse4", "azure3")) +
  labs(x = "Mean Population Density per state; averaged over years 1990-2020", 
       y = "CO2 concentration, measured in metric tons of carbon dioxide equivalent", 
       col = "US States vs Washington") +
  theme_minimal()


