local function bsp(max, pass, lowKey, highKey)
  local mid = max / 2
  local diff = mid / 2

  for c in pass:gmatch('.') do
    if c == lowKey then
      mid = mid - diff
    elseif c == highKey then
      mid = mid + diff
    end

    diff = diff / 2
  end

  return math.ceil(mid) - 1
end

local seats = {}

for pass in io.lines() do
  local rowStr, seatStr = pass:match('([FB]+)([LR]+)')

  local row, seat = bsp(128, rowStr, 'F', 'B'), bsp(8, seatStr, 'L', 'R')
  local id = row * 8 + seat

  seats[id] = true
end

for id,_ in pairs(seats) do
  if not seats[id + 1] and seats[id + 2] then
    print(id + 1)
    return
  end
end
