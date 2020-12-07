local function bagSearch(bags, current, targetColor)
  if current.color == targetColor then return true end
  if #current.children == 0 then return false end

  for _,cb in pairs(current.children) do
    if bagSearch(bags, bags[cb.color], targetColor) then
      return true
    end
  end

  return false
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
local count = 0

for color, bag in pairs(bags) do
  if color ~= targetColor and bagSearch(bags, bag, targetColor) then
    count = count + 1
  end
end

print('Total possible outermost bags:', count)
