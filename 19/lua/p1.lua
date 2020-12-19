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

local rules = {}

local file = io.read('a')

local pos, npos = file:find('\n\n')
local rulesStr = file:sub(0, pos - 1)
local messagesStr = file:sub(npos + 1)

for i, rule in rulesStr:gmatch('(%d+):%s+([^\n]+)') do
  rules[tonumber(i)] = rule
end

-- expand rule 0
local possibleMessages = expandRule(rules, rules[0])

local count = 0

for msg in messagesStr:gmatch('[^\n]+') do
  for _,v in pairs(possibleMessages) do
    if msg == v then count = count + 1 end
  end
end

print(count)
