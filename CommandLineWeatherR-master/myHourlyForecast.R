suppressMessages(library('RJSONIO'));
suppressMessages(library('RCurl'));

source('~/Development/rprogramming/CommandLineWeatherR/getWeatherImage.R');
source('~/Development/rprogramming/CommandLineWeatherR/kelvinToFarenheit.R');
source('~/Development/rprogramming/CommandLineWeatherR/getCurrentLocation.R');

# Change to your id. Getting an ID from OpenWeather.org is Free
appId <- "10c94e0253609fd9f78e207f831b2b09";

args <- commandArgs(trailingOnly = TRUE);
imagePath <- args[1];

locationData <- getCurrentLocation();

currentWeather <- getURL(paste("http://api.openweathermap.org/data/2.5/forecast?lat=",
                               locationData$latitude, 
                               "&lon=", locationData$longitude,
                               "&APPID=", appId, sep=''));
weatherData <- fromJSON(currentWeather);

# Hourly Weather for the Next 24 Hours
# The Open Weather API gets data for weather in 3 hour increments.
# Therefore, to get weather for the next 24 hrs you just look at the first 8 (24/3 = 8)
# entries in the weatherData$list.

for (i in 1:8){
  farenheitCurrentTemp <- kelvinToFarenheit(weatherData$list[[i]]$main["temp"]);
  currentCondition <- weatherData$list[[i]]$weather[[1]]$description;
  getWeatherImage(weatherData$list[[i]]$weather[[1]]$icon, paste(imagePath, i, sep = ''));
  
  # Writes out the weather. Modify this to write out the weather in whatever format you prefer.
  cat( "Weather @ ",weatherData$list[[i]]$dt_txt,"\n",
       "Condition: ", currentCondition, "\n",
       "Temp: ", farenheitCurrentTemp, "° F\n\n", sep='');
}