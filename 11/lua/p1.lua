local FLOOR = '.'
local EMPTY = 'L'
local OCCUPIED = '#'

local function copyGrid(g)
  local copy = {}

  for r = 0, #g do
    local row = {}

    for c = 0, #g[r] do
      row[c] = g[r][c]
    end

    copy[r] = row
  end

  return copy
end

local function countOccupiedNeighbors(grid, r, c)
  local bounds = {
    left = c - 1,
    right = c + 1,
    top = r - 1,
    bottom = r + 1
  }

  if bounds.left < 0 then bounds.left = 0 end
  if bounds.right > #grid[r] then bounds.right = #grid[r] end
  if bounds.top < 0 then bounds.top = 0 end
  if bounds.bottom > #grid then bounds.bottom = #grid end

  local count = 0
  for nr = bounds.top, bounds.bottom do
    for nc = bounds.left, bounds.right do
      if not(nr == r and nc == c) and grid[nr][nc] == OCCUPIED then count = count + 1 end
    end
  end

  return count
end

local function applyRules(grid)
  local current = copyGrid(grid)
  local changeCount = 0

  for r = 0, #current do
    for c = 0, #current[r] do
      if current[r][c] ~= FLOOR then
        local count = countOccupiedNeighbors(current, r, c)

        if current[r][c] == EMPTY and count == 0 then
          changeCount = changeCount + 1
          grid[r][c] = OCCUPIED
        end
        if current[r][c] == OCCUPIED and count >= 4 then
          changeCount = changeCount + 1
          grid[r][c] = EMPTY
        end
      end
    end
  end

  return changeCount
end

local function printGrid(grid)
  for r = 0, #grid do
    local s = ''
    for c = 0, #grid[r] do
      s = s .. grid[r][c]
    end
    print(s)
  end
end

local grid = {}

local r = 0
for line in io.lines() do
  local row = {}

  local c = 0
  for v in line:gmatch('.') do
    row[c] = v

    c = c + 1
  end

  grid[r] = row

  r = r + 1
end

while applyRules(grid) > 0 do
end

local count = 0
for r = 0, #grid do
  for c = 0, #grid[r] do
    if grid[r][c] == OCCUPIED then count = count + 1 end
  end
end

print('Occupied count', count)
