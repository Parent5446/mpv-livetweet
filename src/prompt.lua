local function system(cmd)
  local proc = io.popen(cmd)
  local body = proc:read('*all')
  local ok = proc:close()
  return ok, body
end


local function trim(str)
  str = str:gsub('^%s+', '')
  str = str:gsub('%s+$', '')
  return str
end


local function tmpname_windows()
  return os.getenv('TEMP') .. os.tmpname() .. '_lua'
end


local function prompt_linux(default_msg)
  return system(
    'zenity --text "Tweet body" --title "mpv-livetweet" ' ..
      '--ok-label "Tweet" ' ..
      '--entry --entry-text "' .. default_msg .. '"'
  )
end


local function prompt_macos(default_msg)
  return system(
    [[osascript ]] ..
      [[-e 'set tweet to (]] ..
        [[display dialog "Tweet body" with title "mpv-livetweet" ]] ..
        [[buttons {"Cancel", "Tweet"} ]] ..
        [[default button "Tweet" cancel button "Cancel" ]] ..
        [[default answer "]] .. default_msg .. [["]] ..
      [[)' ]] ..
      [[-e 'if button returned of tweet is "Cancel" then return -128' ]] ..
      [[-e 'return text returned of tweet' ]]
  )
end


local function prompt_windows(default_msg)
  local script_file = tmpname_windows() .. '.vbs'

  local script = 
    'body = InputBox("Tweet body", "mpv-livetweet", "' .. default_msg .. '")\r\n' ..
    'If IsEmpty(body) Then ' ..
      'WScript.Quit(-1) ' ..
    'Else ' ..
      'WScript.Stdout.Write(body) ' ..
    'End If'
  local f = io.open(script_file, 'w')
  f:write(script)
  f:close()

  local ok, body = system('cscript /Nologo ' .. script_file)

  os.remove(script_file)

  return ok, body
end


local function prompt(OS, default_msg)
  assert(OS)
  local ok, body

  if     OS == 'linux' then
    ok, body = prompt_linux(default_msg)
  elseif OS == 'macos' then
    ok, body = prompt_macos(default_msg)
  elseif OS == 'windows' then
    ok, body = prompt_windows(default_msg)
  end

  if ok then
    return trim(body)
  end
end


return {
  prompt = prompt
}
