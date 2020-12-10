local adapters = { 0 } -- The outlet has a rating of 0

for j in io.read('a'):gmatch('%d+') do
  table.insert(adapters, tonumber(j))
end

table.sort(adapters)

table.insert(adapters, adapters[#adapters] + 3) -- Device joltage

local counts = { 0, 0, 0 }
for i = 1, #adapters - 1 do
  local diff = adapters[i + 1] - adapters[i]
  counts[diff] = counts[diff] + 1
end

print('1-jolt count', counts[1], '3-jolt count', counts[3], 'product', counts[1] * counts[3])
