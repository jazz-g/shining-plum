local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- commands that each button does
local cmd_shutdown = "systemctl poweroff"
local cmd_restart = "systemctl reboot"
local cmd_hibernate = beautiful.homePath .. ".config/awesome/scripts/i3lock-script.sh && systemctl hibernate"
local cmd_sleep = beautiful.homePath .. ".config/awesome/scripts/i3lock-script.sh && systemctl suspend"
local cmd_lock = beautiful.homePath .. ".config/awesome/scripts/i3lock-script.sh"

-- creating the widgets
local w_shutdown = wibox.widget {
	widget = wibox.widget.imagebox,
	image= beautiful.homePath .. ".config/awesome/icons/system-shutdown.png",
	align = "center",
	valign = "center",
	resize = false,
}
local w_restart = wibox.widget {
	widget = wibox.widget.imagebox,
	image= beautiful.homePath .. ".config/awesome/icons/view-refresh.png",
	align = "center",
	valign = "center",
	resize = false,
}
local w_hibernate = wibox.widget {
	widget = wibox.widget.imagebox,
	image = beautiful.homePath .. ".config/awesome/icons/system-suspend-hibernate.png",
	align = "center",
	valign = "center",
	resize = false,
}
local w_sleep = wibox.widget {
	widget = wibox.widget.imagebox,
	image = beautiful.homePath .. ".config/awesome/icons/system-suspend.png",
	align = "center",
	valign = "center",
	resize = false,
}
local w_lock = wibox.widget {
	widget = wibox.widget.imagebox,
	image = beautiful.homePath .. ".config/awesome/icons/system-lock-screen.png",
	align = "center",
	valign = "center",
	resize = false,
}

-- connecting commands to the buttons
w_shutdown:connect_signal("button::press", function()
	awful.spawn(cmd_shutdown)
	end)
w_restart:connect_signal("button::press", function()
	awful.spawn(cmd_restart)
	end)
w_hibernate:connect_signal("button::press", function()
	awful.spawn(cmd_hibernate)
	end)
w_sleep:connect_signal("button::press", function()
	awful.spawn(cmd_sleep)
	end)
w_lock:connect_signal("button::press", function()
	awful.spawn(cmd_lock)
	end)


local widget_SysStop = wibox.widget {
	wibox.widget {
	w_shutdown,
	w_restart,
	w_hibernate,
	w_sleep,
	w_lock,
	point = {x=28,y=72},
	layout = wibox.layout.flex.horizontal,
	},
	layout = wibox.layout.manual,

}


return widget_SysStop
