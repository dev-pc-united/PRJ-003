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

currentWeather <- getURL(paste("http://api.openweathermap.org/data/2.5/weather?lat=",
                               locationData$latitude, 
                               "&lon=", locationData$longitude, 
                               "&APPID=", appId, sep=''));
weatherData <- fromJSON(currentWeather);

farenheitCurrentTemp <- kelvinToFarenheit(weatherData$main["temp"]);
farenheitHighTemp <- kelvinToFarenheit(weatherData$main["temp_max"]);
farenheitLowTemp <- kelvinToFarenheit(weatherData$main["temp_min"]);
currentCondition <- weatherData$weather[[1]]$description;

# Writes out the weather. Modify this to write out the weather in whatever format you prefer.
cat( "Latest Weather Station: ", weatherData$name,"\n",
     "Current Condition: ", currentCondition, "\n",
     "Current Temp: ", farenheitCurrentTemp, "° F\n",
     "High Temp: ", farenheitHighTemp, "° F\n",
     "Low Temp: ", farenheitLowTemp, "° F.\n", sep='');

# Retrieves the image based on the weather returned in getURL
getWeatherImage( weatherData$weather[[1]]$icon, imagePath);