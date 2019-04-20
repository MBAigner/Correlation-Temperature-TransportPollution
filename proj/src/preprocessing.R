######################################
# Load and preprocess data sets
######################################


######################################
# 1.) Load temperature

loadTemperature <- function(path, begin = 1990, end = 2016){
  
  temperature <- read.csv2(path)
  names(temperature) <- c("Year", "January", "February", "March", "April", "May", "June", "July", 
                          "August", "September", "October", "November", "December", "avg")
  # Preview of original data
  head(temperature)
  
  # Remove years that are not included in expenditures and remove avg (will be calculated
  # more exactly afterwards)
  temperature <- temperature[temperature$Year >= begin & temperature$Year <= end, -14]
  
  # Calculate more accurate average of temperature for a year
  temperature$avgTemperature <- rowMeans(temperature[, -1])
  
  # Remove monthly values
  temperature <- temperature[, c(1, 14)]
  
  # Return temperature data frame
  return(temperature)
}


######################################
# 2.) Air pollution indicator

loadPollution <- function(path, begin = 1990, end = 2016){
  # Get just the first row (contains the indicator for Austria) and
  # remove its name
  pollution <- read.delim(path, header = T,
                          stringsAsFactors = F)[1, -1]
  
  # Create subset of given years
  pollution <- pollution[, (1990 - begin) + 1 : (end-begin + 1)]
  
  # The data contains sometimes spaces additionally to a tab as a separator,
  # so we need to make all values numeric.
  for(j in 1:ncol(pollution)){
    pollution[,j] <- as.numeric(pollution[,j])
  }
  
  # Return pollution data frame
  return(pollution)
}





######################################
# Combine data

loadCombinedData <- function(temperaturePath, pollutionPath, 
                             begin = 1990, end = 2016){
  # Load single data sets
  temp <- loadTemperature(temperaturePath, 1990, 2016)
  pol <- loadPollution(pollutionPath, 1990, 2016)
  
  # Combine data sets
  data <- cbind(temp, t(pol))
  names(data) <- c("Year", "avgTemperature", "pollutionIndicator")
  
  # Return combined data frame
  return(data)
}



