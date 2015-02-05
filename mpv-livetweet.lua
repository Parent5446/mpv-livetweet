-- Options
oauth-token = "Paste the oauth_token key here"
oauth-token-secret = "Paste the oauth_token_secret key here"
keybind = "alt+w"
shot = "/tmp/shot.png"
text = ""

-- Script
local twitter = require 'luatwit'
local mputils = require 'mp.utils'

local keys = {
	consumer_key = "7svu0BZBvEqCuA3XbCUbXoHPA",
	consumer_secret = "6U8RyN55VctvYtoh0mgBqUO8p2gLqQFvFP0MRDLhUhOEOMrZTi",
	oauth_token = "oauth-token",
	oauth_token_secret = "oauth-token-secret"
}

function tweet()
	mp.resume()
	mp.commandv("screenshot_to_file", shot, "video")
	local file = io.open(shot)
	local img_data = file:read("*a")
	file:close()
	os.remove(shot)

	local client = twitter.new(keys)
	local tw, headers = client:tweet_with_media{
		status = text, ["media[]"] = {
			filename = shot,
			data = img_data,
		},
	}
	mp.osd_message("Screenshot tweeted!", 5)
end

mp.add_key_binding(keybind, "tweet", function() tweet() end)