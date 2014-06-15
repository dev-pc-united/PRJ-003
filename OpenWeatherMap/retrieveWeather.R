# You'll need to have a database connection through RODBC in order to be able to save stuff to a database.
# See this link for more information: http://stackoverflow.com/questions/10292326/how-to-connect-r-with-mysql-or-how-to-install-rmysql-package 
# Getting todays stuff and future stuff shouldn't be saved in database.
# I believe we need a cronjob in order to retrieve past weather data.
# That way it'll always save the latest data found.


# -- Make sure to install these through install.packages();
library("RJSONIO");
library("RCurl");
library("RODBC"); 

# -- Don't need these messages
suppressMessages(library('RJSONIO'));
suppressMessages(library('RCurl'));

# -- Required sources
#source('getWeatherImage.R');
#source('kelvinToFarenheit.R');
#source('getCurrentLocation.R');

# -- Required variables
appId <- "10c94e0253609fd9f78e207f831b2b09"; # -- Gained from getting an account on openweathermap.org
cityId <- "2757783"; # -- Since we only use one city, only retrieve data from this city.
#Date <- NULL; # -- Date asked to find. Y-M-D <-- Should have no time
todaysDateUnix <- as.numeric(as.POSIXct(Sys.Date(), format="%Y-%m-%d"));
weatherTable <- "weatherdata";

# -- test Variables
# date <- as.numeric(as.POSIXct(Sys.Date(), format="%Y-%m-%d")) - 90495;
date <- as.Date(Sys.Date(), format="%Y %m %d") - 1;
dateUnix <- as.numeric(as.POSIXct(date, format="%Y-%m-%d"));
# print(date);
# print(date+1);
# print(dateUnix);
# -- Retrieve data from today
# Example format: http://api.openweathermap.org/data/2.5/weather?id=2757783
if( dateUnix == todaysDateUnix ){
  
  weather <- getURL(paste("http://api.openweathermap.org/data/2.5/weather?id=", cityId, "&appID=", appId));
  weather <- fromJSON(weather);

# -- Retrieve data from the future
# Example format: http://api.openweathermap.org/data/2.5/forecast?id=2757783
# Limitations: 16 days in the future
} else if( dateUnix > todaysDate ) {
  
  days <- diff( c( todaysDateUnix, date ) ) / 60 / 60 / 24;
  
  if(days <= 16){
    
  } else {
    print("The date specified is not in the range of 16 days.");
  }
  
  # -- First check if limitation is reached
  #Days <- diff(TodaysDate, date) * 60 * 60 * 24;
  #print(Days)
  
  
  weather <- getURL(paste("http://api.openweathermap.org/data/2.5/forecast?id=", cityId, "&appID=", appId));
  weather <- fromJSON(weather);

# -- Retrieve data from the past
# Example format: http://api.openweathermap.org/data/2.5/history/station?id=2757783&type=day
# Limitations: 30 days in the past1
} else if ( dateUnix < todaysDateUnix ) {
  
  #First look if the date specified is in the database.
  db <- odbcConnect("pietpaulusma");
  #sqlTables(db);  
  #date <- "2014-06";
  
  query <- paste("SELECT * FROM weatherdata AS wa WHERE wa.weatherdata_date = DATE_FORMAT(", date, ", '%Y %m %d' )", sep="")
  results <- sqlQuery(db, query);
  
  print(query);
  print(results);
  
  print(length(results));
  print(length(results$weatherdata_id));
  
  # See if results are found...
  if(length(results$weatherdata_id) > 0 ){
  
  # No results? Check the date, then fetch it.
  } else {

    days <- diff( c( todaysDateUnix, date ) ) / 60 / 60 / 24;
    
    if( days <= 30 ){
    } else {
      print("The date specified is not in the range of 30 days.");
    }
    
    dateTomorrow = date+1;
    dateTomorrowUnix <- as.numeric(as.POSIXct(dateTomorrow, format="%Y-%m-%d"));
    
    #1369728000&end=1369789200
    # http://api.openweathermap.org/data/2.5/history/station?id=2757783&type=day
    # print(as.POSIXct(date, origin="1970-01-01"));
    # print(as.POSIXct(as.Date(date+1, origin="1970-01-01"), origin="1970-01-01"));
    # print(as.POSIXct(1369728000, origin="1970-01-01"));
    # print(as.POSIXct(1369789200, origin="1970-01-01"));
    
    weather <- getURL(paste("http://api.openweathermap.org/data/2.5/history/city?id=", cityId, "&appID=", appId, "&cnt=24&start=", dateUnix));
    weather <- fromJSON(weather);
    
    for(weatherRow in weather){
      #save each row...
      
      #print(weatherRow[. "dt"]);
    }
    
  }
    

}
#print(weather);
#print(as.POSIXct(weather$dt, origin="1970-01-01"));