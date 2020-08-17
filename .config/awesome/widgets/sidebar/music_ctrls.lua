local wibox = require("wibox")
local awful = require("awful")
local mpc = require("mpc")
local gears = require("gears")
local beautiful = require("beautiful")

-- Image Paths
local path = beautiful.homePath .. ".config/awesome/icons/media-"

local skip_f = path .. "skip-forward.png"
local skip_b = path .. "skip-backward.png"
local play = path .. "playback-start.png"
local pause = path .. "playback-pause.png"

local state = "stop"

-- Base Widgets
local widget_toggle_s = wibox.widget{
	align = "center",
	valign = "center",
	image = play,
	resize = false,
	widget = wibox.widget.imagebox
}

local widget_skip_f = wibox.widget{
	align = "center",
	valign = "center",
	image = skip_f,
	resize = false,
	widget = wibox.widget.imagebox
}

local widget_skip_b = wibox.widget{
	align = "center",
	valign = "center",
	image = skip_b,
	resize = false,
	widget = wibox.widget.imagebox
}



-- Widget that contains all the buttons
local media_controls = wibox.widget{
	layout = wibox.layout.align.horizontal,
	widget_skip_b,
	widget_toggle_s,
	widget_skip_f,
	expand = "none",
	align = "center",
	valign = "center",
}

-- Connecting Button press signals to signal functions
widget_toggle_s:buttons(gears.table.join(
	awful.button({}, 1, function()
		-- Toggles the state of mpd
		awful.spawn("mpc toggle")
	end)
))

widget_skip_f:buttons(gears.table.join(
	awful.button({}, 1, function()
		-- Toggles the state of mpd
		awful.spawn("mpc next")
	end)
))

widget_skip_b:buttons(gears.table.join(
	awful.button({}, 1, function()
		-- Toggles the state of mpd
		awful.spawn("mpc prev")
	end)
))

-- Update widget function that MPD connection calls
local function update_widget()
	if state == "pause" then
		widget_toggle_s:set_image(play)
	else if state == "play" then
		widget_toggle_s:set_image(pause)
	else
		widget_toggle_s:set_image(play)
	end
end
end

-- MPD Socket Connection stuff I don't understand, but works regardless. (copy-pasted from awesomewm docs)

local function error_handler(err)
    -- Try a reconnect soon-ish
    timer.start_new(10, function()
        connection:send("ping")
    end)
end

local connection
connection = mpc.new(nil, nil, nil, error_handler,
    "status", function(_, result)
        state = result.state
        pcall(update_widget)
    end)

return media_controls
