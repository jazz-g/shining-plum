#!/usr/bin/env python3

import pyowm

# Put api key here
owm = pyowm.OWM('#########################################')

wObservation = owm.weather_at_zip_code('01451', 'us')

weather = wObservation.get_weather()

status = weather.get_status()
# replace with 'fahrenheit' to use F instead of C
temps = weather.get_temperature('celsius')
high = temps['temp_max']
low = temps['temp_min']
temp = temps['temp']

# logic to figure out what icon to use
code = weather.get_weather_code()
code_f = int(str(code)[0])
weather_icon = ""

if code_f == 2:
    weather_icon = "thunder"
elif code_f == 3 or code_f == 5:
    weather_icon = "rain"
elif code_f == 6:
    weather_icon = "snow"
elif code_f == 7:
    weather_icon = "fog"
elif code == 800:
    weather_icon = "sun"
elif code == 801 or code == 802:
    weather_icon = "cloudy_sun"
elif code == 803 or code == 804:
    weather_icon = "cloudy"
else:
    weather_icon = ""

# puts escape symbols around the vars so lua can figure out what's what more easily
print("|" + weather_icon + "|")
print("$" + status + "$")
print("?" + str(temp) + "?")
print("&" + str(high) + "&")
print("%" + str(low) + "%")
