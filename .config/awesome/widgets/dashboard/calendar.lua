local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

local w_calendar = wibox.widget {
	wibox.widget {
		date = os.date('*t'),
		widget = wibox.widget.calendar.month,
		start_sunday = true,
		font = "Cabin Regular 14",
		week_numbers = false,
		long_weekdays = true,
		align = "center",
		valign = "center",
		forced_height = 570,
		forced_width = 425,
	},
	layout = wibox.layout.align.horizontal,
}

return w_calendar
