local function createMask(line)
  local mask = {}
  local v = line:match('mask = ([X01]+)')
  local len = v:len()

  for c in v:gmatch('[X01]') do
    mask[len - 1] = c
    len = len - 1
  end

  return mask
end

local function getAllAddresses(n, mask)
  local addresses = {}
  local xs = {}

  for i,c in pairs(mask) do
    local bit = 1 << i
    if c == '1' then
      n = n | bit
    elseif c == 'X' then
      table.insert(xs, i)
      if n & bit > 0 then
        n = n - bit
      end
    end
  end

  table.insert(addresses, n)

  for _,v in pairs(xs) do
    for i = #addresses, 1, -1 do
      table.insert(addresses, addresses[i] + (1 << v))
    end
  end

  return addresses
end

local memory = {}
local mask = nil

for line in io.lines() do
  if line:find('mask') then
    mask = createMask(line)
  else
    local addr,v = line:match('mem%[(%d+)%] = (%d+)')

    local addresses = getAllAddresses(tonumber(addr), mask)
    for _,a in pairs(addresses) do
      memory[a] = tonumber(v)
    end
  end
end

local sum = 0
for i,v in pairs(memory) do
  sum = sum + v
end

print(sum)
