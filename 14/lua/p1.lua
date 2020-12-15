local function applyMask(n, mask)
  for i,v in pairs(mask) do
    local bit = 1 << i
    if v == 0 and n & bit > 0 then
      n = n - bit
    elseif v == 1 and n & bit == 0 then
      n = n + bit
    end
  end
  return n
end

local function createMask(line)
  local mask = {}
  local v = line:match('mask = ([X01]+)')
  local len = v:len()

  for c in v:gmatch('[X01]') do
    if c ~= 'X' then
      mask[len - 1] = tonumber(c)
    end
    len = len - 1
  end

  return mask
end

local memory = {}
local mask = nil

for line in io.lines() do
  if line:find('mask') then
    mask = createMask(line)
  else
    local addr, v = line:match('mem%[(%d+)%] = (%d+)')
    memory[tonumber(addr)] = applyMask(tonumber(v), mask)
  end
end

local sum = 0
for i,v in pairs(memory) do
  print(string.format('mem[%d] = %d', i, v))
  sum = sum + v
end

print(sum)
