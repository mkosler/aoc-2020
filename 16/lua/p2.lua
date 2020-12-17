local Set = require 'set'

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
  local count = 0

  for name, b1, b2, b3, b4 in s:gmatch('([^:\n]+): (%d+)%-(%d+) or (%d+)%-(%d+)') do
    count = count + 1
    t[name] = function (n)
      return (tonumber(b1) <= n and n <= tonumber(b2)) or (tonumber(b3) <= n and n <= tonumber(b4))
    end
  end

  return t, count
end

local function convertToTickets(s, ruleCount)
  local tickets = {}
  local t = {}

  for n in s:gmatch('%d+') do
    table.insert(t, tonumber(n))

    if #t == ruleCount then
      table.insert(tickets, t)
      t = {}
    end
  end

  return tickets
end

local function isValidTicket(ticket, rules)
  for _,n in pairs(ticket) do
    local passed = false

    for name,f in pairs(rules) do
      if f(n) then
        passed = true
        break
      end
    end

    if not passed then return false end
  end

  return true
end

local function removeInvalidTickets(tickets, rules)
  local cleanedTickets = {}

  for _,t in pairs(tickets) do
    if isValidTicket(t, rules) then
      table.insert(cleanedTickets, t)
    end
  end

  return cleanedTickets
end

local function getValidRulesForNumber(n, rules)
  local r = Set:create()

  -- print('for', n)
  for name,f in pairs(rules) do
    if f(n) then
      -- print(name)
      r:add(name)
    end
  end

  return r
end

local function getValidRulesForTicket(ticket, rules)
  local valids = {}

  for i,n in ipairs(ticket) do
    valids[i] = getValidRulesForNumber(n, rules)
  end

  return valids
end

local function createInitialValidRuleSet(rules)
  local set = Set:create()

  for name,_ in pairs(rules) do
    set:add(name)
  end

  return set
end

local input = split(io.read('a'), '\n\n')
local rules, ruleCount = parseRules(input[1])
local myTicket = convertToTickets(input[2], ruleCount)[1]
local tickets = removeInvalidTickets(convertToTickets(input[3], ruleCount), rules)

local validRulesForTickets = {}

for _,t in pairs(tickets) do
  table.insert(validRulesForTickets, getValidRulesForTicket(t, rules))
end

local combinedRules = {}

for i = 1, ruleCount do
  local combined = createInitialValidRuleSet(rules)

  for _,t in pairs(validRulesForTickets) do
    combined = Set.intersection(combined, t[i])
  end

  table.insert(combinedRules, combined)
end

local rulesByPosition = {}
local count = 0

while count < ruleCount do
  for i,cr in pairs(combinedRules) do
    local t = cr:toTable()

    if #t == 1 then 
      rulesByPosition[i] = t[1]
      count = count + 1

      for _,cr2 in pairs(combinedRules) do
        cr2:remove(t[1])
      end
    end
  end
end

local product = 1

for i,name in ipairs(rulesByPosition) do
  if name:find('departure') then
    product = product * myTicket[i]
  end
end

print(product)
