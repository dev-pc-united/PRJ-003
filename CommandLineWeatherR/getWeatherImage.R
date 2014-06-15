getWeatherImage <- function (imageName, imagePath) {
  imageLocation <- paste("http://openweathermap.org/img/w/", imageName, ".png", sep='');
  f <- CFILE(paste(imagePath, ".png", sep=''), mode="wb");
  curlPerform(url = imageLocation, writedata = f@ref);
  msg.trap <- capture.output(suppressMessages(close(f)));
}