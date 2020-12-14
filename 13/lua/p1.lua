local earliest = tonumber(io.read())

local minDiff = math.huge
local minId = nil
for id in io.read():gmatch('%d+') do
  id = tonumber(id)
  local diff = id - (earliest % id)

  if diff < minDiff then
    minDiff = diff
    minId = id
  end
end

print(minDiff, minId, minDiff * minId)

-- math.ceil(939 / 7) * 7 = 945 (945 - 939) = 6, 939 % 7 = 1 (7 - 1) = 6
-- math.ceil(939 / 13) * 13 = 949 (949 - 939) = 10, 939 % 13 = 3 (13 - 3) = 10
-- math.ceil(939 / 59) * 59 = 944 (944 - 939) = 5, 939 % 59 = 54 (59 - 34) = 5
