local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Commands to be run to get the CPU usage
local get_cpu_cmd = beautiful.homePath .. ".config/awesome/scripts/getcpu.sh"

local main_color = beautiful.widget_yellow


-- Creation of Bar Widget
local cpu_bar = wibox.widget {
	{
		max_value = 1,
		value = 0.1,
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
local cpu_image = wibox.widget {
	image = beautiful.homePath .. ".config/awesome/icons/cpu.png",
	widget = wibox.widget.imagebox,
	align = "center",
	resize = false,
	valign = "center",
}

-- Creation of the metawidget
local widget_cpu = wibox.widget {
	cpu_image,
	cpu_bar,
	layout = wibox.layout.fixed.horizontal,
	align = "center",
	valign = "center",
}

-- Refreshes Widget every second
function widget_cpu.init()
	watch(get_cpu_cmd, 5, 
		function(widget, stdout, stderr, _, _)
			widget.widget.value = tonumber(string.match(stdout, "%d.%d*"))


		end,
		cpu_bar)
end

return widget_cpu

