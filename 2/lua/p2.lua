local validPasswords = 0

local file = io.read('a')

for p1, p2, letter, password in file:gmatch('(%d+)%-(%d+)%s+(%a):%s+(%a+)') do
  p1, p2 = tonumber(p1), tonumber(p2)

  local count = 0

  if password:sub(p1, p1) == letter then count = count + 1 end
  if password:sub(p2, p2) == letter then count = count + 1 end

  if count == 1 then
    validPasswords = validPasswords + 1
  end
end

print('validPasswords', validPasswords)
