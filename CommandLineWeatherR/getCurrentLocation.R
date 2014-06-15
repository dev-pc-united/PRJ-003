getCurrentLocation <-function() {
  currentLocation <- getURL("http://www.telize.com/geoip");
  fromJSON(currentLocation);  
}