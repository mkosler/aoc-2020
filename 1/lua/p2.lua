local expenses = {}

for line in io.lines() do
  table.insert(expenses, tonumber(line))
end

for _,a in pairs(expenses) do
  for _,b in pairs(expenses) do
    for _,c in pairs(expenses) do
      if a ~= b and a ~= c and b ~= c and a + b + c == 2020 then
        print(a, b, c, a * b * c)
        return
      end
    end
  end
end
