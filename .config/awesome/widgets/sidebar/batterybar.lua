local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Commands to be run to get the battery level
local get_batt_cmd = "acpi -b"

local main_color = beautiful.widget_red


-- Creation of Bar Widget
local batt_bar = wibox.widget {
	{
		max_value = 100,
		value = 10,
		widget = wibox.widget.progressbar,
		shape = gears.shape.rounded_bar,
		bar_shape = gears.shape.rounded_bar,
		border_color = beautiful.fg_focus,
		background_color = beautiful.bg_normal,
		border_width = 2,
		color = main_color,
		align = "center",
		valign = "center",
		forced_height = 5,
		--forced_width = 325,
		margins = { left = 15, top = 13, bottom = 13, right = 33}
	},
	--direction = "east",
	layout = wibox.container.rotate,
}


-- Creation of imagebox widget
local batt_image = wibox.widget {
	image = beautiful.homePath .. ".config/awesome/icons/battery.png",
	widget = wibox.widget.imagebox,
	align = "center",
	resize = false,
	valign = "center",
}

-- Creation of the metawidget
local widget_batt = wibox.widget {
	batt_image,
	batt_bar,
	layout = wibox.layout.fixed.horizontal,
	align = "center",
	valign = "center",
}

-- Refreshes Widget every 5 seconds
function widget_batt.init()
	watch(get_batt_cmd, 5, 
		function(widget, stdout, stderr, _, _)
			percent = string.match(stdout, "%d+%%")
			widget.widget.value = tonumber(percent:sub(1, -2))

		end,
		batt_bar)
end

return widget_batt

