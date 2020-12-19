local function evaluate(statement)
  print('current statement', statement)
  local res = nil
  local operator = nil

  while statement:find('%b()') do
    statement = statement:gsub('%b()', function (s) return evaluate(s:sub(2, -2)) end)
  end

  while statement:find('(%d+) %+ (%d+)') do
    statement = statement:gsub('(%d+) %+ (%d+)', function (a, b) return tonumber(a) + tonumber(b) end)
  end

  while statement:find('(%d+) %* (%d+)') do
    statement = statement:gsub('(%d+) %* (%d+)', function (a, b) return tonumber(a) * tonumber(b) end)
  end

  return tonumber(statement)
end

local sum = 0
for line in io.lines() do
  local n = evaluate(line)
  print(string.format('%s = %d', line, n))
  sum = sum + n
end

print('Total', sum)
