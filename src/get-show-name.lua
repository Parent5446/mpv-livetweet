local strings = require('strings')

-- Use dumb heuristics to extract a normalized show name
local function get_show_name(filename, extension)
  local query = filename

  query = query:gsub('%.' .. extension,     '') -- extension
  query = query:gsub('%b[]',                '') -- everything inside braces
  query = query:gsub('%b()',                '') -- everything inside parens
  query = query:gsub('%d%d%a?%d?',          '') -- episode number and version
  query = query:gsub('[Ss]pecial[a-zA-Z]?', '') -- special

  query = query:gsub('_',             ' ') -- underscores
  query = query:gsub('[^a-zA-Z0-9]',  ' ') -- anything that's not alphanumeric
  query = query:gsub('%s+',           ' ') -- collapse spaces

  return strings.trim(query)
end

return {
  get_show_name = get_show_name
}
