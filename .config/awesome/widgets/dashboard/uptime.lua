local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Uptime command
local get_upt_cmd = "uptime -p"

-- Creation of textbox widget
local widget_uptime = wibox.widget {
	widget = wibox.widget.textbox,
	font = "Cabin 14",
	align = "center",
	valign = "center",
}

-- Refreshes Widget every minute
function widget_uptime.init()
	watch(get_upt_cmd, 60, 
		function(widget, stdout, stderr, _, _)
			widget.text = string.match(stdout, "[%w %p]+")

		end,
		widget_uptime)
end

return widget_uptime

