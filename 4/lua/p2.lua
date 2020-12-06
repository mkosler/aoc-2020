local validCount = 0

local validationRules = {
  byr = function (v)
    v = tonumber(v)
    return v ~= nil and 1920 <= v and v <= 2002
  end,

  iyr = function (v)
    v = tonumber(v)
    return v ~= nil and 2010 <= v and v <= 2020
  end,

  eyr = function (v)
    v = tonumber(v)
    return v ~= nil and 2020 <= v and v <= 2030
  end,

  hgt = function (v)
    local i,m = v:match('(%d+)(%a%a)')
    i = tonumber(i)

    if m == 'cm' then return 150 <= i and i <= 193 end
    if m == 'in' then return 59 <= i and i <= 76 end
    return false
  end,

  hcl = function (v)
    return v:len() == 7 and v:find('#%x+') ~= nil
  end,

  ecl = function (v)
    local colors = { 'amb', 'blu', 'brn', 'gry', 'grn', 'hzl', 'oth' }

    for _,c in pairs(colors) do
      if v == c then return true end
    end

    return false
  end,

  pid = function (v)
    return v:len() == 9 and tonumber(v) ~= nil
  end,
}

local function validate(pp)
  local t = {}

  for k,v in pp:gmatch('(%w+):([#%w]+)') do
    t[k] = v
  end

  local pass = true

  for field,test in pairs(validationRules) do
    if t[field] == nil or not test(t[field]) then
      return false
    end
  end

  return true
end

-- Hack to "seperate" by empty lines
local file = io.read('a'):gsub('\n\n', '|')

for v in file:gmatch('[^|]+') do
  if validate(v) then validCount = validCount + 1 end
end

print('valid passports', validCount)
