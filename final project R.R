library(stringr)
library(dplyr)
library(ggplot2)
library(tidyr)

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
pop_2_df <- pop_1_df[pop_1_df$Year > 1990,]

#remove representitive data
pop_3_df <- subset(pop_2_df, select = c("State", "Year", "Resident Population", "Percent Change in Resident Population", "Resident Population Density", "Resident Population Density Rank"))

#cleaning emissions df
emissions_1_df <- emissions_df[emissions_df$unit == "MtCO2e",]
#emissions_2_df <- gather(emissions_1_df, key = "Year", value = "Value", 1990:2020)
emissions_2_df <- unite(emissions_1_df, col = Year, cols(3:33)

#add a column for gas level in combined df
joined_1_df <- 
