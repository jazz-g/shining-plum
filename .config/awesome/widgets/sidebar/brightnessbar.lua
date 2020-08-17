local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Commands to be run to get/set the brightness
local get_bright_cmd = "brightnessctl -m"
local add_bright_cmd = "brightnessctl -q s 5%+"
local sub_bright_cmd = "brightnessctl -q s 5%-"

local main_color = beautiful.widget_main_color


-- Creation of Bar Widget
local bright_bar = wibox.widget {
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

-- Allow Progressbar to control brightness
bright_bar:connect_signal("button::press", function(_, _, _, button)
	if button == 4 then
		awful.spawn(add_bright_cmd)
	elseif button == 5 then
		awful.spawn(sub_bright_cmd)
	end 

end)

-- Creation of imagebox widget
local bright_image = wibox.widget {
	image = beautiful.homePath .. ".config/awesome/icons/brightness.png",
	widget = wibox.widget.imagebox,
	align = "center",
	resize = false,
	valign = "center",
}

-- Creation of the metawidget
local widget_bright = wibox.widget {
	bright_image,
	bright_bar,
	layout = wibox.layout.fixed.horizontal,
	align = "center",
	valign = "center",
}

-- Refreshes Widget every second
function widget_bright.init()
	watch(get_bright_cmd, 1, 
		function(widget, stdout, stderr, _, _)
			percent = string.match(stdout, "%d+%%")
			widget.widget.value = tonumber(percent:sub(1, -2))

		end,
		bright_bar)
end

return widget_bright

