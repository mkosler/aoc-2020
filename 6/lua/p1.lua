local file = io.read('a'):gsub('\n\n', '|'):sub(1, -2)

local sum = 0

for group in file:gmatch('[^|]+') do
  local answers = {}

  for c in group:gmatch('%a') do
    if not answers[c] then
      answers[c] = true
      sum = sum + 1
    end
  end
end

print('Sum of counts', sum)
