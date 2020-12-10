local function factorial(n)
  if n == 0 then return 1 end

  for i = 1, n - 1 do
    n = n * i
  end
  return n
end

local function choose(n, r)
  return factorial(n) / (factorial(n - r) * factorial(r))
end

local adapters = { 0 } -- The outlet has a rating of 0

for j in io.read('a'):gmatch('%d+') do
  table.insert(adapters, tonumber(j))
end

table.sort(adapters)

table.insert(adapters, adapters[#adapters] + 3) -- Device joltage

local chains = {}

local c = {}
for i = 1, #adapters do
  if #c > 0 and adapters[i] - c[#c] == 3 then
    table.insert(chains, c)
    c = {}
  end

  table.insert(c, adapters[i])
end

local arrangements = 1

for _,c in ipairs(chains) do
  if #c >= 3 then
    local count = 0
    local innerLength = #c - 2

    -- Without testing for invalid connections, the raw count is this sum of combinations
    for i = 0, innerLength do
      count = count + choose(innerLength, i)
    end

    -- Each gap between values in the chain greater than 3 produces an invalid combination
    for i = 1, #c - 1 do
      for j = i + 1, #c do
        if c[j] - c[i] > 3 then count = count - 1 end
      end
    end

    arrangements = arrangements * count
  end
end

print('total combinations', arrangements, test)

-- 0 2 3 5 6
-- 0   3 5 6
-- 0 2   5 6
-- 0 2 3   6
-- 0     5 6 INVALID
-- 0   3   6
-- 0 2     6 INVALID
-- 0       6 INVALID
--
-- 19208 = 7 * 7 * 7 * 7 * 2 * 2 * 2
--
-- 0 2 4 5
-- 0   4 5
-- 0 2   5
-- 0     5 INVALID
