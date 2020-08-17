local mpc = require("mpc")
local timer = require("gears.timer")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")

-- Textbox for the Song Title
mpd_title = wibox.widget{
	text = "--------",
	align = "center",
	valign = "center",
	font = "Product Sans Regular 17",
	widget = wibox.widget.textbox
}

-- Textbox for the Artist name
mpd_artist = wibox.widget{
	text = "---------",
	align = "center",
	valign = "center",
	font = "Product Sans Regular 16",
	widget = wibox.widget.textbox
}

mpd_song = wibox.widget{
	mpd_title,
	mpd_artist,
	layout = wibox.layout.fixed.vertical
}

local state, title, artist, file = "stop", "", "", ""
local function update_widget()
    local stitle = ""
    local sartist = ""
    -- Saves current artist & title into additional variable for textboxes
    sartist = tostring(artist or "") 
    stitle = tostring(title or "")
    -- Tests if MPD is paused or stopped to change the text properly
    if state == "stop" then
        stitle = stitle .. " (stopped)"
    end
    -- Updates the textboxes in the sidebar 
    mpd_title.text = stitle
    mpd_artist.text = sartist
end

-- MPD Socket Connection stuff I don't understand, (copy-pasted from awesomewm docs)
local function error_handler(err)
    mpd_widget:set_text("Error: " .. tostring(err))
    -- Try a reconnect soon-ish
    timer.start_new(10, function()
        connection:send("ping")
    end)
end

local connection
connection = mpc.new(nil, nil, nil, error_handler,
    "status", function(_, result)
        state = result.state
    end,
    "currentsong", function(_, result)
        title, artist, file = result.title, result.artist, result.file
        pcall(update_widget)
	
    end)

return mpd_song
