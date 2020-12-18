local function getActiveNeighborCount(activeCubes, cx, cy, cz)
  local count = 0

  for x = -1, 1 do
    for y = -1, 1 do
      for z = -1, 1 do
        if not(x == 0 and y == 0 and z == 0) and activeCubes[string.format('%d,%d,%d', cx + x, cy + y, cz + z)] then
          count = count + 1
        end
      end
    end
  end

  return count
end

local function cycle(activeCubes, bounds)
  local changes = {}

  for x = bounds.min.x, bounds.max.x do
    for y = bounds.min.y, bounds.max.y do
      for z = bounds.min.z, bounds.max.z do
        local activeNeighbors = getActiveNeighborCount(activeCubes, x, y, z)
        local str = string.format('%d,%d,%d', x, y, z)

        if activeCubes[str] then
          if not(activeNeighbors == 2 or activeNeighbors == 3) then
            table.insert(changes, { cube = str, state = nil, x = x, y = y, z = z })
          end
        else
          if activeNeighbors == 3 then
            table.insert(changes, { cube = str, state = true, x = x, y = y, z = z })
          end
        end
      end
    end
  end

  for _,v in pairs(changes) do
    activeCubes[v.cube] = v.state

    if v.state then
      if v.x == bounds.min.x then bounds.min.x = v.x - 1 end
      if v.y == bounds.min.y then bounds.min.y = v.y - 1 end
      if v.z == bounds.min.z then bounds.min.z = v.z - 1 end

      if v.x == bounds.max.x then bounds.max.x = v.x + 1 end
      if v.y == bounds.max.y then bounds.max.y = v.y + 1 end
      if v.z == bounds.max.z then bounds.max.z = v.z + 1 end
    end
  end
end

local function printState(activeCubes, bounds)
  for z = bounds.min.z, bounds.max.z do
    io.write(string.format('z=%d\n', z))
    for y = bounds.min.y, bounds.max.y do
      for x = bounds.min.x, bounds.max.x do
        if activeCubes[string.format('%d,%d,%d', x, y, z)] then
          io.write('#')
        else
          io.write('.')
        end
      end
      io.write('\n')
    end
  end
end

local initialState = io.read('a'):sub(1, -2) -- trim endline newline
local activeCubes = {}
local x,y = 0,0
local bounds = {
  min = { x = -1, y = -1, z = -1 },
  max = { z = 1 }
}

for c in initialState:gmatch('[#.\n]') do
  if c == '#' then
    activeCubes[string.format('%d,%d,%d', x, y, 0)] = true
  end

  x = x + 1

  if c == '\n' then
    x = 0
    y = y + 1
  end
end

bounds.max.x = x
bounds.max.y = y + 1

print(bounds.min.x, bounds.max.x)
print(bounds.min.y, bounds.max.y)
print(bounds.min.z, bounds.max.z)

local cycleCount = 0
while cycleCount < 6 do
  cycleCount = cycleCount + 1

  cycle(activeCubes, bounds)
end

local activeCount = 0
for _,v in pairs(activeCubes) do
  if v then activeCount = activeCount + 1 end
end

print(activeCount)
