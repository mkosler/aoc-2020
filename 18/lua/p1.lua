local function evaluate(statement)
  local res = nil
  local operator = nil
  local s = ''
  local parenCount = 0

  for c in statement:gmatch('%S') do
    if parenCount > 0 then
      if c == ')' then
        parenCount = parenCount - 1

        if parenCount == 0 then
          local n = evaluate(s)
          if res == nil then
            res = n
          elseif operator == '+' then
            res = res + n
          elseif operator == '*' then
            res = res * n
          end

          s = ''
        else
          s = s .. c
        end
      else
        if c == '(' then
          parenCount = parenCount + 1
        end
        s = s .. c
      end
    else
      local n = tonumber(c)
      if n ~= nil then
        if res == nil then
          res = n
        else
          if operator == '+' then
            res = res + n
          elseif operator == '*' then
            res = res * n
          end
        end
      elseif c == '(' then
        parenCount = parenCount + 1
      else
        operator = c
      end
    end
  end

  return res
end

local sum = 0
for line in io.lines() do
  local n = evaluate(line)
  print(string.format('%s = %d', line, n))
  sum = sum + n
end

-- print('Total', sum)
