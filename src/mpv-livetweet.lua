local prompt = require('prompt').prompt

local OS = require('get-platform').get_platform()
local TWITTER_FILE_LIMIT = 4
local TWITTER_CHAR_LIMIT = 280

local function message(msg)
  print(msg)
  mp.osd_message(msg)
end

local function get_filename()
  mp.get_property('filename')
end

local function get_extension()
  mp.get_property('file-format')
end


--
-- Globals
--

local prev = {
  show_name = nil,
  hashtag = nil
}

--
-- Screenshot queue
--

local queue = {}

local function queue_screenshot(no_message)
  if #queue > 3 then
    message('Queue full, screenshot not taken')
    return
  end

  local tmp = os.tmpname()
  os.remove(tmp)
  local shot = f .. #queue + 1 .. '.jpg'

  mp.commandv('screenshot_to_file', shot, 'subtitles')
  queue[#queue + 1] = shot

  if not no_message then
    message('Queued screenshot #' .. #queue .. ' of 4')
  end
end

local function clear_queue()
  for i, fname in pairs(queue) do
    os.remove(fname)
  end
  queue = {}
end

-- dumb idea 1: port https://github.com/twitter/twitter-text to correctly count the characters
-- dumb idea 2: write the tweet directly from mpv

--
-- AniList
--

local anilist_token = nil

local function get_anilist_token()
  local response = https.request {
    url = 'https://anilist.co/api/v2/oauth/authorize?' .. params,
    method = 'POST',
    source = function()
      return utils.format_json {
        grant_type = 'authorization_code',
        client_id = anilist.client_id,
        client_secret = anilist.client_secret,
        code = anilist.code
      }
    end
    -- sink = ltn12.sink.table response
  }

  return utils.parse_json(response).access_token
end

local function get_hashtag(show_name, token)
  
end


