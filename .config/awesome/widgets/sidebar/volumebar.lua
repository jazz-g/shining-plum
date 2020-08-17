local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Commands to be run to get/set the volume
local get_volume_cmd = "pamixer --get-volume --get-mute"
local add_volume_cmd = "pamixer -i 5"
local sub_volume_cmd = "pamixer -d 5"
local tog_mute_cmd = "pamixer -t"

local main_color = beautiful.border_focus
local mute_color = beautiful.bg_normal


-- Creation of Bar Widget
local volume_bar = wibox.widget {
	{
		max_value = 100,
		value = 5,
		widget = wibox.widget.progressbar,
		shape = gears.shape.rounded_bar,
		bar_shape = gears.shape.rounded_bar,
		border_color = beautiful.fg_focus,
		background_color = beautiful.bg_normal,
		border_width = 2,
		align = "center",
		valign = "center",
		forced_height = 5,
		--forced_width = 325,
		margins = { left = 15, top = 13, bottom = 13, right = 33}
	},
	--direction = "east",
	layout = wibox.container.rotate,
}

-- Allow Progressbar to control volume
volume_bar:connect_signal("button::press", function(_, _, _, button)
	if button == 4 then
		awful.spawn(add_volume_cmd)
	elseif button == 5 then
		awful.spawn(sub_volume_cmd)
	elseif button == 1 then
		awful.spawn(tog_mute_cmd)
	end 

end)

-- Creation of imagebox widget
local volume_image = wibox.widget {
	image = beautiful.homePath .. ".config/awesome/icons/audio-icon.png",
	widget = wibox.widget.imagebox,
	align = "center",
	resize = false,
	valign = "center",
}

-- Creation of the metawidget
local widget_volume = wibox.widget {
	volume_image,
	volume_bar,
	layout = wibox.layout.fixed.horizontal,
	align = "center",
	valign = "center",
}

-- Refreshes Widget every second
function widget_volume.init()
	watch(get_volume_cmd, 1, 
		function(widget, stdout, stderr, _, _)
			if string.match(stdout, "%a+") == "true" then
				--Widgets not changing color, is this the right object?
				widget.widget.color = mute_color
			else
				widget.widget.color = main_color
			end
			widget.widget.value = tonumber(string.match(stdout, "%d+"))
		end,
		volume_bar)
end

return widget_volume

