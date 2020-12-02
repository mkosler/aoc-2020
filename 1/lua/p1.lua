local expenses = {}

for line in io.lines() do
  table.insert(expenses, tonumber(line))
end

for _,a in pairs(expenses) do
  for _,b in pairs(expenses) do
    if a ~= b and a + b == 2020 then
      print(a, b, a * b)
      return
    end
  end
end
