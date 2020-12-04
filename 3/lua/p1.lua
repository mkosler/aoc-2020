-- Row major
local map = {}
local i, j = 0, 0

for line in io.lines() do
  local row = {}
  j = 0

  for c in line:gmatch('.') do
    row[j] = c == '#'
    j = j + 1
  end

  map[i] = row
  i = i + 1
end

local pos = { r = 0, c = 0 }
local velocity = { dc = 3, dr = 1 }
local treeCount = 0

while pos.r < i do
  pos.c = (pos.c + velocity.dc) % j
  pos.r = pos.r + velocity.dr

  -- Awkward
  if pos.r >= i then
    break
  end

  if map[pos.r][pos.c] then treeCount = treeCount + 1 end
end

print('treeCount', treeCount)
