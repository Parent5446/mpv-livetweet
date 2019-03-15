local function trim(str)
  str = str:gsub('^%s+', '')
  str = str:gsub('%s+$', '')
  return str
end

return {
  trim = trim
}
