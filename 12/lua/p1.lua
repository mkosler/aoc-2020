local ship = {
  x = 0,
  y = 0,
  rot = 0
}

for line in io.lines() do
  local action, magn = line:match('([NSEWLRF])(%d+)')
  magn = tonumber(magn)

  if action == 'N' then
    ship.y = ship.y + magn
  elseif action == 'S' then
    ship.y = ship.y - magn
  elseif action == 'E' then
    ship.x = ship.x + magn
  elseif action == 'W' then
    ship.x = ship.x - magn
  elseif action == 'L' then
    ship.rot = (ship.rot + magn) % 360
  elseif action == 'R' then
    ship.rot = (ship.rot - magn) % 360
  elseif action == 'F' then
    local rad = math.rad(ship.rot)
    local fx = magn * math.cos(rad)
    local fy = magn * math.sin(rad)
    ship.x = ship.x + fx
    ship.y = ship.y + fy
  end
end

print(math.abs(ship.x) + math.abs(ship.y))
