local validPasswords = 0

local file = io.read('a')

for min, max, letter, password in file:gmatch('(%d+)%-(%d+)%s+(%a):%s+(%a+)') do
  local count = 0

  password:gsub(letter, function ()
    count = count + 1
  end)

  if tonumber(min) <= count and count <= tonumber(max) then
    validPasswords = validPasswords + 1
  end
end

print('validPasswords', validPasswords)
