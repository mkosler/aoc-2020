local function split(s, delim)
  local t = {}

  while true do
    local pos, npos = s:find(delim)

    if not pos then break end

    table.insert(t, s:sub(0, pos - 1))
    s = s:sub(npos + 1)
  end

  table.insert(t, s)

  return t
end

local function parseRules(s)
  local t = {}

  for name, b1, b2, b3, b4 in s:gmatch('(%a+): (%d+)%-(%d+) or (%d+)%-(%d+)') do
    t[name] = function (n)
      return (tonumber(b1) <= n and n <= tonumber(b2)) or (tonumber(b3) <= n and n <= tonumber(b4))
    end
  end

  return t
end

local function getInvalidValues(nearby, rules)
  local t = {}

  for n in nearby:gmatch('%d+') do
    local passed = false
    n = tonumber(n)

    for name,f in pairs(rules) do
      if f(n) then
        passed = true
        break
      end
    end

    if not passed then table.insert(t, n) end
  end

  return t
end

local input = split(io.read('a'), '\n\n')
local rules = parseRules(input[1])
local invalids = getInvalidValues(input[3], rules)

local sum = 0
for _,v in pairs(invalids) do sum = sum + v end
print(sum)
