CommandLineWeatherR
===================

Retrieves the current Weather using the Open Weather API and retrieving your current location from www.telize.com/geoip using R and displays the local weather based on this information. Therefore, if you run this on a laptop you take on travel then it should normally be able to find your local weather without you having to reconfigure it. However, if you are on a big corporate network that routes its ip traffic through a distant location then this will give the weather at that location instead of your local area. To fix this you would have to make a minor modification to the script to take in your city name or lat long. 

This project was created solely for learning, personal enjoyment, and because I was bored. There is no warrenty of any type. Anyone familiar with software engineering can readily see numerous places this code can be improved. However, this can be used in at least 2 ways.

- First: It can be simply used to disply current weather on the command line.
-- To do this just download the script modify the path in the myWeather.R and the getHourlyForecast.R files to be wherever you downloaded thecode to. Save and run
-- Secondly and optionaly create Shell script called weather and put the call to the script in there. Move the shell script to your /usr/bin/ directory Set the permissions chmod uga+rwx weather
- Second: It can be used with either Conky on linux or GeekTool on Mac OS X to display the Weather the Desktop.

To use this application you must have R installed with the RCurl and RJSONIO packages. If you do not have those installed, see the documentation at http://cran.r-project.org.

This application uses my APPID key from Open Weather. Change that key to your key by signing up at http://openweathermap.org/API. This key can be found on line 12 in the source code as part of the URL.

Assuming the prerequisites are met, this application can be run by typing:

Rscript myWeather.R FULLPATH_INCLUDING_FILE_NAME


Example: Rscript myWeather.R  ~/test/myImage
or
Example: Example: Rscript myHourlyForecast.R ~/test/myImage

Additionally, the script will download an image of the current weather and place it in the directory and name the dowloaded file using the FULLPATH_INCLUDING_FILE_NAME name you pass in. It will overright the image each time the script is run. Therefore, if you are wanting to run the script for multiple locations at once, such as in GeekTool or Conky, give each command a unique FULLPATH_INCLUDING_FILE_NAME. Don't put the extension on the end the program automatically appends .png to whatever you pass in. There is no error checking of any kind on the inputs so it will error out if anything is wrong.

The myForecast code doesn't currently work but is meant to be a retrieve the daily weather for the next 3 days.  The code in that file is just a cut and paste and hasn't even been looked at.
