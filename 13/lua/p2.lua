io.read() -- discard first line

local ids, i = {}, 0
for id in io.read():gmatch('[x%d]+') do
  if id ~= 'x' then
    ids[i] = tonumber(id)
  end
  i = i + 1
end

-- local function test(ids, mult, f)
--   for off,v in pairs(ids) do
--     -- if v ~= f then
--       local n = (f * mult) + off
--       -- if mult == 152683 then
--       --   print(f, off, mult, v, n, n % v)
--       -- end
--       if n % v > 0 then return false end
--       print(f, off, mult, v, n, n % v)
--     -- end
--   end
--   return true
-- end

-- local x = 1
-- while true do
--   if test(ids, x, ids[0]) then
--     break
--   end

--   x = x + 1
-- end

-- local function test(f, mult, v, offset)
--   return ((f * mult) + offset) % v == 0
-- end

-- local function testAll(f, mult, ids)
--   for off,v in pairs(ids) do
--       if not test(f, mult, v, off) then return false end
--     -- if v ~= f then
--       print(string.format('f: %d, off: %d, mult: %d v: %d', f, off, mult, v))
--     -- end
--   end

--   return true
-- end

-- local function findFirstWorkingId(ids, f)
--   local x = 1
--   while true do
--     for off,v in pairs(ids) do
--       -- if v ~= f then
--         if test(f, x, v, off) then return x, v end
--       -- end
--     end
--     x = x + 1
--   end
--   error('Que?')
-- end

-- local step, x = findFirstWorkingId(ids, ids[0])
-- print(step, x)
-- while true do
--   if testAll(ids[0], x, ids) then
--     break
--   end

--   x = x + step
-- end

local function findFirstAtOffset(f, v, off)
  local x = 1
  while ((f * x) + off) % v > 0 do
    x = x + 1
  end
  return x
end

for off,v in pairs(ids) do
  print(v, off, findFirstAtOffset(ids[0], v, off))
end

-- print(ids[0], x, ids[0] * x)

-- 3417 = 17 * 3 * 67 = 17 * 201
--
-- 17,x,13,19
-- 17,x,13*(17+2),19*(17+3)
-- 17, 13*(19), 19*(20)
-- 17, 247, 380
--
-- 17, 19 % 13 == 0?, 20 % 19 == 0?
--
-- t = 17 * n
-- (17 * n) + 2 = 13 * b (if n = 201, b = 263) (if n = 6, b = 8)
-- (17 * n) + 3 = 19 * c (if n = 201, b = 180) (if n = 6, b = (105/19))
