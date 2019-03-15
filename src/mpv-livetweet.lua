local prompt = require('prompt').prompt
local anilist = require('anilist')
local get_show_name = require('get-show-name').get_show_name

local utils = require('mp.utils')

local OS = require('get-platform').get_platform()
local TWITTER_FILE_LIMIT = 4
local TWITTER_CHAR_LIMIT = 280

local function message(msg)
  print(msg)
  mp.osd_message(msg)
end

local function get_filename()
  return mp.get_property('filename')
end

local function get_extension()
  return mp.get_property('file-format')
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

local function do_stuff()
  local show_name = get_show_name(get_filename(), get_extension())
  local hashtag

  if show_name ~= prev.show_name then
    local ok, h = anilist.search_hashtag(show_name, {
      encode = utils.format_json,
      decode = utils.parse_json
    })

    hashtag = h and h or ''

    prev.hashtag = hashtag
    prev.show_name = show_name
  else
    hashtag = prev.hashtag
  end

  local ok, text = prompt(OS, hashtag)
  if not ok then
    message('canceled')
    return
  end

  message(text)
end


mp.add_key_binding('Alt+a', do_stuff)
