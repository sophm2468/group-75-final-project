library(stringr)
library(dplyr)
library(ggplot2)
library(tidyr)
library(tidyverse)

emissions_df <- ghg_emissions
pop_df <- apportionment

#join everything into a dataframe

names(pop_df)[1] <- "State"
names(emissions_df)[1] <- "State"
joined_df <- full_join(pop_df, emissions_df, by = "State")

#cleaning pop_df

#remove regions
pop_1_df <- pop_df[pop_df$`Geography Type` == "State",]

#remove unneeded years
pop_2_df <- pop_1_df[pop_1_df$Year >= 1990,]

#remove representitive data
pop_3_df <- subset(pop_2_df, select = c("State", "Year", "Resident Population", "Percent Change in Resident Population", "Resident Population Density", "Resident Population Density Rank"))

#cleaning emissions df
emissions_1_df <- emissions_df[emissions_df$unit == "MtCO2e",]

# Transform the dataset
emissions_2_df <- emissions_1_df %>%
  gather(key = "Year", value = "units", `1990`:`2020`) %>%
  select(`State`, Year, units)

#change the name of the columns
names(emissions_2_df)[3] <- "MtCO2e level"

#change strings to numerics
emissions_2_df$Year <- as.numeric(emissions_2_df$Year)

#join the cleaned dataframes
final_2_df <- full_join(emissions_2_df, pop_3_df, by = c("State", "Year"))

final_df <- merge(emissions_2_df, pop_3_df, by = c("State", "Year"))
