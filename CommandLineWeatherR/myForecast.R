suppressMessages(library('RJSONIO'));
suppressMessages(library('RCurl'));

# Change to your id. Getting an ID from OpenWeather.org is Free
appId <- "68ec37ac14cb53ab45c1eb6ab2198dcb ";

kelvinToFarenheit <- function (kelvinTemp) {
  (kelvinTemp - 273.15)*1.8 + 32;
}

getWeatherImage <- function (imageName, imagePath) {
  imageLocation <- paste("http://openweathermap.org/img/w/", imageName, ".png", sep='');
  f <- CFILE(paste(imagePath, ".png", sep=''), mode="wb");
  curlPerform(url = imageLocation, writedata = f@ref);
  msg.trap <- capture.output(suppressMessages(close(f)));
}

args <- commandArgs(trailingOnly = TRUE);
latitude <- args[1];
longitude <- args[2];
imagePath <- args[3];


# http://api.openweathermap.org/data/2.5/weather?id=2757783

currentWeather <- getURL(paste("http://api.openweathermap.org/data/2.5/weather?id=2757783&APPID=", appId, sep=''));


# currentWeather <- getURL(paste("http://api.openweathermap.org/data/2.5/forecast?lat=",
#                               latitude, 
#                               "&lon=", longitude, 
#                               "&APPID=", appId, sep=''));

weatherData <- fromJSON(currentWeather);

print(weatherData);
# farenheitCurrentTemp <- kelvinToFarenheit(weatherData$main["temp"]);
# farenheitHighTemp <- kelvinToFarenheit(weatherData$main["temp_max"]);
# farenheitLowTemp <- kelvinToFarenheit(weatherData$main["temp_min"]);
# currentCondition <- weatherData$weather[[1]]$description;

# Writes out the weather. Modify this to write out the weather in whatever format you prefer.
# cat( "Latest Weather Station: ", weatherData$name,"\n",
#      "Current Condition: ", currentCondition, "\n",
#      "Current Temp: ", farenheitCurrentTemp, "° F\n",
#      "High Temp: ", farenheitHighTemp, "° F\n",
#      "Low Temp: ", farenheitLowTemp, "° F.\n", sep='');

# Retrieves the image based on the weather returned in getURL
#getWeatherImage( weatherData$weather[[1]]$icon, imagePath);