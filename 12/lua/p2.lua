local ship = {
  x = 0,
  y = 0,
}

local waypoint = {
  x = 10,
  y = 1,
}

for line in io.lines() do
  local action, magn = line:match('([NSEWLRF])(%d+)')
  magn = tonumber(magn)

  if action == 'N' then
    waypoint.y = waypoint.y + magn
  elseif action == 'S' then
    waypoint.y = waypoint.y - magn
  elseif action == 'E' then
    waypoint.x = waypoint.x + magn
  elseif action == 'W' then
    waypoint.x = waypoint.x - magn
  elseif action == 'L' or action == 'R' then
    if action == 'R' then
      magn = -magn
    end

    local rad = math.rad(magn)
    local nx = waypoint.x * math.cos(rad) - waypoint.y * math.sin(rad)
    local ny = waypoint.x * math.sin(rad) + waypoint.y * math.cos(rad)
    waypoint.x = nx
    waypoint.y = ny
  elseif action == 'F' then
    ship.x = ship.x + (magn * waypoint.x)
    ship.y = ship.y + (magn * waypoint.y)
  end
end

print(math.abs(ship.x) + math.abs(ship.y))
