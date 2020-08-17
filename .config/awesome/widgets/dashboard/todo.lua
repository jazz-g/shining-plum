local awful = require("awful")
local beautiful = require("beautiful")
local wibox = require("wibox")
local gears = require("gears")
local watch = require("awful.widget.watch")

-- Todo command
local get_todo_cmd = beautiful.homePath .. ".config/awesome/scripts/getTodo.sh"

local todo_list = wibox.widget {
		widget = wibox.widget.textbox,
		font = "Cabin 13",
		align = "center",
		valign = "center",
		text = "",
		color = beautiful.fg_normal,
	}

-- Creation of textbox widget
local widget_todo  = wibox.widget {
	wibox.widget {
		widget = wibox.widget.textbox,
		font = "Cabin Bold 19",
		align = "center",
		valign = "center",
		text = "To Do",
		color = beautiful.fg_normal,
	},
	todo_list,
	layout = wibox.layout.fixed.vertical,
}

-- Refreshes Widget every minute
function widget_todo.init()
	watch(get_todo_cmd, 60,
		function(widget, stdout, stderr, _, _)
			widget.text = string.match(stdout, ".+")

		end,
		todo_list)
end

return widget_todo

