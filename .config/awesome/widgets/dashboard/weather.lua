local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Uptime command
local get_weather_cmd = beautiful.homePath .. ".config/awesome/scripts/weather.py"

-- Icon paths
local awesomedir = beautiful.homePath .. ".config/awesome/icons/"

local sunpath = awesomedir .. "weather-sunny.png"
local cloudpath = awesomedir .. "weather-cloudy.png"
local fogpath = awesomedir .. "weather-fog.png"
local partcloudpath = awesomedir .. "weather-partly-cloudy.png"
local rainpath = awesomedir .. "weather-rainy.png"
local snowpath = awesomedir .. "weather-snow.png"
local thunderpath = awesomedir .. "weather-thunder.png"

local weather_status = wibox.widget {
	widget = wibox.widget.textbox,
	font = "Cabin Bold 19",
	align = "center",
	valign = "center",
}

local temp_high = wibox.widget {
	widget = wibox.widget.textbox,
	font = "Cabin Regular 14",
	align = "center",
	valign = "center",
}

local temp_low = wibox.widget {
	widget = wibox.widget.textbox,
	font = "Cabin Regular 14",
	align = "center",
	valign = "center",
}

local temp_now = wibox.widget {
	widget = wibox.widget.textbox,
	font = "Cabin Regular 17",
	align = "center",
	valign = "center",
}


local weather_icon = wibox.widget {
	widget = wibox.widget.imagebox,
	image = "",
	align = "center",
	valign = "center",
	resize = false,
	clip_shape = gears.shape.rounded_rect,
	forced_height = 100,
	forced_width = 100,
	point = {x = 102, y = 0},
}

local weather_icon_container = wibox.widget {
	layout = wibox.layout.manual,
	weather_icon,
}

-- Creation of container widget
local widget_weather_container = wibox.widget {
	layout = wibox.layout.flex.vertical,
	weather_status,
	weather_icon_container,
	temp_now,
	temp_low,
	temp_high,
	spacing = -25,
}

-- Updates the widget
local function update_widget(icon, status, tempN, tempL, tempH)
	temp_now.text = tempN .. "°C"
	temp_low.text = "Low of " .. tempL
	temp_high.text = "High of " .. tempH
	weather_status.text = status
	if icon == "thunder" then
		weather_icon.image = thunderpath
	elseif icon == "rain" then
		weather_icon.image = rainpath
	elseif icon == "snow" then
		weather_icon.image = snowpath
	elseif icon == "fog" then
		weather_icon.image = fogpath
	elseif icon == "sun" then
		weather_icon.image = sunpath
	elseif icon == "cloudy_sun" then
		weather_icon.image = partcloudpath
	elseif icon == "cloudy" then
		weather_icon.image = cloudpath
	else
		weather_icon.image = ""
	end
end

-- Refreshes Widget every 5 minutes
function widget_weather_container.init()
	watch(get_weather_cmd, 300, 
		function(widget, stdout, stderr, _, _)
			icon = string.sub(string.match(stdout, "|.+|"), 2, -2)
			status = string.sub(string.match(stdout, "%$.+%$"), 2, -2)
			tempN = string.sub(string.match(stdout, "%?.+%?"), 2, -2)
			tempL = string.sub(string.match(stdout, "%%.+%%"), 2, -2)
			tempH = string.sub(string.match(stdout, "&.+&"), 2, -2)
			if icon == nil or status == nil or tempN == nil or tempH == nil then
				
			else
				update_widget(icon, status, tempN, tempL, tempH)
			end
		end,
		widget_weather_container)
end

return widget_weather_container
