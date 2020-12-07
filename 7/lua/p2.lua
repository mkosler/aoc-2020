local function totalBagCount(bags, current)
  local sum = 0

  if current.children == 0 then return sum end

  for _,cb in pairs(current.children) do
    sum = sum + cb.count + (cb.count * totalBagCount(bags, bags[cb.color]))
  end

  return sum
end

local bags = {}

for rule in io.lines() do
  local b = {
    color = rule:match('^(%a+ %a+)'),
    children = {}
  }

  for count, color in rule:gmatch('(%d+) (%a+ %a+) bag[s]?') do
    table.insert(b.children, {
      count = count,
      color = color
    })
  end

  bags[b.color] = b
end

local targetColor = 'shiny gold'
local sum = totalBagCount(bags, bags[targetColor])

print('Total bags within:', sum)
