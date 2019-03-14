-- I copied this from https://github.com/rossy/mpv-repl
local function get_platform()
  local o = {}

  if mp.get_property_native('options/vo-mmcss-profile', o) ~= o then
    return 'windows'
  -- TURNS OUT this doesn't actually work
  elseif mp.get_property_native('options/input-app-events', o) ~= o then
    return 'macos'
  else
    return 'linux'
  end
end

return {
  get_platform = get_platform
}
