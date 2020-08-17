local awful = require("awful")
local wibox = require("wibox")
local gears = require("gears")
local beautiful = require("beautiful")

local userPicture = wibox.widget{
	image = beautiful.homePath .. ".config/awesome/default/profile_pic.png",
	resize = false,
	widget = wibox.widget.imagebox,
	clip_shape = gears.shape.rounded_rect,
	align = "center",
	valign = "center",
	point = {x=103, y=103, width=300, height=300},
}

	
local userName = wibox.widget{
	text = "u/Osiris834",
	font = "Anka/Coder Regular 20",
	widget = wibox.widget.textbox,
	align = "center",
	valign = "center",
	color = beautiful.fg_normal,
	point = {x=167,y=445},
}

local widget_userPicture = wibox.widget{
	layout = wibox.layout.manual,
	align = "center",
	valign = "center",
	userPicture,
	userName,
}


return widget_userPicture
