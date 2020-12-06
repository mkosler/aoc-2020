local validCount = 0

local requiredFields = {
  'byr',
  'iyr',
  'eyr',
  'hgt',
  'hcl',
  'ecl',
  'pid'
}

local function validate(pp)
  for _,field in pairs(requiredFields) do
    if pp:find(field..':') == nil then return false end
  end
  return true
end

-- Hack to "seperate" by empty lines
local file = io.read('a'):gsub('\n\n', '|')

for v in file:gmatch('[^|]+') do
  if validate(v) then validCount = validCount + 1 end
end

print(validCount)
