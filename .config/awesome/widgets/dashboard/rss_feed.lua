local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Uptime command
local get_feed_cmd = beautiful.homePath .. ".config/awesome/scripts/getRss.sh"

-- Creation of textbox widget
local widget_rss  = wibox.widget {
	widget = wibox.widget.textbox,
	font = "Cabin 13",
	align = "center",
	valign = "center",
	text = "",
	color = beautiful.fg_normal,
}

-- Refreshes Widget every 15 minutes
function widget_rss.init()
	watch(get_feed_cmd, 900, 
		function(widget, stdout, stderr, _, _)
			widget.text = string.match(stdout, ".+")

		end,
		widget_rss)
end

return widget_rss

