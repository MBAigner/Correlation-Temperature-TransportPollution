######################################
# Load used libraries
library(ggcorrplot)
library(ggplot2)
library(dplyr)
library(tidyr)

# Load preprocessing data functions
# Make sure to have your working directory set to the proj directory
source("./src/preprocessing.R")


######################################
# 1.) Load data

# Firstly, we define the time interval (in years) that we want to observe
begin <- 1990
end <- 2016

# Load combined data
data <- loadCombinedData("./data/monatsmitteltemperaturen-ab-1971.csv",
                 "./data/t2020_rk300.tsv", begin, end)

# Store final data set for analysis
write.csv2(data, file = "./output/analysis_data.csv",
           row.names = F, quote = F)


######################################
# 1.) Correlation

correlation <- cor(data)
correlation

# Heatmap
jpeg("./figures/temperature_pollution_heatmap.jpg", height = 400, width = 600)
ggcorrplot(correlation)
dev.off()
# One can see a quite strong negative correlation between year and
# the pollution indicator, meaning that the pollution indicator has a
# negative trend.
# Also, there is a weak positive correlation between a year and the
# average temperature for it.

######################################
# 2.) Line chart of pollution indicator and average temperature per year

jpeg("./figures/temperature_pollution_linechart.jpg", height = 400, width = 600)
data %>%
  # min max scaling of values
  mutate(averageTemperature = (avgTemperature - min(avgTemperature)) /
           (max(avgTemperature) - min(avgTemperature))) %>%
  mutate(pollutionIndicator = (pollutionIndicator - min(pollutionIndicator)) / 
           (max(pollutionIndicator) - min(pollutionIndicator))) %>%
  # write data in one column
  gather("Indicator", "value", averageTemperature, pollutionIndicator) %>%
  # plot data
  ggplot(aes(x = Year, y = value, colour = Indicator)) + 
  geom_line()
dev.off()

# There is no pattern visible between the average temperature and
# pollution indicator per year.

######################################
# 3.) Smoothed trend

jpeg("./figures/temperature_pollution_trend.jpg", height = 400, width = 600)
data %>%
  # min max scaling of values
  mutate(averageTemperature = (avgTemperature - min(avgTemperature)) /
           (max(avgTemperature) - min(avgTemperature))) %>%
  mutate(pollutionIndicator = (pollutionIndicator - min(pollutionIndicator)) / 
           (max(pollutionIndicator) - min(pollutionIndicator))) %>%
  # write data in one column
  gather("Indicator", "value", averageTemperature, pollutionIndicator) %>%
  # plot data
  ggplot(aes(x = Year, y = value, colour = Indicator)) + 
  geom_smooth(data$averageTemperature, method = "loess")
dev.off()
# The loess- smoothed values are showing a weak negative correlation between
# average temperature and pollution indicator.
