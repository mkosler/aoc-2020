local file = io.read('a'):gsub('\n\n', '|'):sub(1, -2) -- :sub(1, -2) strips the final newline

local sum = 0

for group in file:gmatch('[^|]+') do
  local answers = {}

  local _,pplCount = group:gsub('\n', '\n')
  pplCount = pplCount + 1 -- count the last line as a person

  for c in group:gmatch('%a') do
    if answers[c] == nil then answers[c] = 0 end

    answers[c] = answers[c] + 1
  end

  for _,a in pairs(answers) do
    if a == pplCount then
      sum = sum + 1
    end
  end
end

print('Sum of counts', sum)
