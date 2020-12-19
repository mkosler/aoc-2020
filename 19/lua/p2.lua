local function cloneTable(t)
  return { table.unpack(t) }
end

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
    local lhs = rule:sub(1, pos - 1)
    local rhs = rule:sub(pos + 1)
    local rhsT = cloneTable(t)

    expandRule(rules, lhs, t)
    expandRule(rules, rhs, rhsT)

    for _,v in ipairs(rhsT) do
      table.insert(t, v)
    end

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
local rulesStr = file:sub(0, pos - 1)
local messagesStr = file:sub(npos + 1)

for i, rule in rulesStr:gmatch('(%d+):%s+([^\n]+)') do
  rules[tonumber(i)] = rule
end

local count = 0

local rule42 = expandRule(rules, rules[42])
local rule31 = expandRule(rules, rules[31])
local fixLength = #rule42[1] -- Assumption is both prefix and suffix are same length

for msg in messagesStr:gmatch('[^\n]+') do
  if #msg % fixLength == 0 then
    print('---')
    local count42 = 0
    local prefix = msg:sub(1, fixLength)
    print(msg, prefix)

    print('rule 42')
    while contains(rule42, prefix) do
      count42 = count42 + 1
      msg = msg:sub(fixLength + 1)
      prefix = msg:sub(1, fixLength)
      print(msg, prefix)
    end

    if count42 >= 2 then
      print('rule 31')
      local count31 = 0
      local suffix = msg:sub(-fixLength)
      print(msg, suffix)

      while contains(rule31, suffix) do
        count31 = count31 + 1
        msg = msg:sub(1, -(fixLength + 1))
        suffix = msg:sub(-fixLength)
        print(msg, suffix)
      end

      if count31 >= 1 and count42 > count31 and #msg == 0 then
        print('counted!')
        count = count + 1
      end
    end
  end
end

print(count)
