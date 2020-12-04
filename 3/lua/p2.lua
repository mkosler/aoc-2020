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

local velocities = {
  { dc = 1, dr = 1 },
  { dc = 3, dr = 1 },
  { dc = 5, dr = 1 },
  { dc = 7, dr = 1 },
  { dc = 1, dr = 2 }
}

local answer = 1

for _,velocity in pairs(velocities) do
  local pos = { r = 0, c = 0 }
  local treeCount = 0

  while pos.r < i do
    pos.c = (pos.c + velocity.dc) % j
    pos.r = pos.r + velocity.dr

    if pos.r >= i then
      break
    end

    if map[pos.r][pos.c] then treeCount = treeCount + 1 end
  end

  answer = answer * treeCount
end

print('answer', answer)
