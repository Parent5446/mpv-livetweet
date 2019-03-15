package.path = package.path .. ';./deps/?.lua'
package.cpath = package.cpath .. ';./deps/?.so'

local https = require 'ssl.https'
local ltn12 = require 'ltn12'

local query = [[
query SearchHashtag ($search: String) {
  Media (search: $search, type: ANIME, sort: POPULARITY_DESC) {
    hashtag
  }
}
]]

-- Takes a table with an encode and decode function.
local function search_hashtag(title, json)
  local body = json.encode {
    query = query,
    variables = { search = title },
  }

  local resp = {}

  local ok = https.request {
    url = 'https://graphql.anilist.co',
    method = 'POST',
    headers = {
      ['Accept'] = 'application/json',
      ['Content-Type'] = 'application/json',
      ['Content-Length'] = #body,
    },
    sink = ltn12.sink.table(resp),
    source = ltn12.source.string(body),
  }

  local hashtag

  if ok then
    resp = json.decode(resp[1]).data.Media
    hashtag = resp and resp.hashtag
  end

  return ok, hashtag
end

return {
  search_hashtag = search_hashtag,
}
