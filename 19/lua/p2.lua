local function expandRule(rules, rule, t)
  t = t or {''}

  if rule:find('"') then
    for i,_ in ipairs(t) do
      t[i] = t[i] .. rule:match('"([^"]+)"')
    end
    return t
  end

  local pos = rule:find('|')
  if pos then
    local rhsT = { table.unpack(t) }

    expandRule(rules, rule:sub(1, pos - 1), t)
    expandRule(rules, rule:sub(pos + 2), rhsT)

    for _,v in ipairs(rhsT) do table.insert(t, v) end

    return t
  end

  for n in rule:gmatch('%d+') do
    expandRule(rules, rules[tonumber(n)], t)
  end

  return t
end

local function contains(t, v)
  for _,w in pairs(t) do
    if v == w then return true end
  end

  return false
end

local rules = {}
local file = io.read('a')
local pos, npos = file:find('\n\n')

for i, rule in file:sub(0, pos - 1):gmatch('(%d+):%s+([^\n]+)') do
  rules[tonumber(i)] = rule
end

local count = 0

local rule42, rule31 = expandRule(rules, rules[42]), expandRule(rules, rules[31])
local fixLength = #rule42[1] -- Assumption is both prefix and suffix are same length

for msg in file:sub(npos + 1):gmatch('[^\n]+') do
  local count42 = 0
  local prefix = msg:sub(1, fixLength)

  while contains(rule42, prefix) do
    count42 = count42 + 1
    msg = msg:sub(fixLength + 1)
    prefix = msg:sub(1, fixLength)
  end

  if count42 >= 2 then
    local count31 = 0
    local suffix = msg:sub(-fixLength)

    while contains(rule31, suffix) do
      count31 = count31 + 1
      msg = msg:sub(1, -(fixLength + 1))
      suffix = msg:sub(-fixLength)
    end

    if count31 >= 1 and count42 > count31 and #msg == 0 then
      count = count + 1
    end
  end
end

print(count)
