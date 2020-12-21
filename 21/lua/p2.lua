local Set = require 'lua/set'

local function wordSplit(s)
  local t = {}
  for w in s:gmatch('%a+') do
    table.insert(t, w)
  end
  return t
end

local function contains(t, v)
  for _,w in pairs(t) do
    if v == w then return true end
  end
  return false
end

local function getOnlyPossible(allergen, food, ingredients)
  for _,i in pairs(food.ingredients) do
    if ingredients[i]:contains(allergen) then
      local passed = true

      for _,ii in pairs(food.ingredients) do
        if i ~= ii and ingredients[ii]:contains(allergen) then
          passed = false
        end
      end

      if passed then return i end
    end
  end

  return nil
end

local function getAllKeys(t)
  local nt = {}
  for k,_ in pairs(t) do table.insert(nt, k) end
  return nt
end

local function getAllValues(t)
  local nt = {}
  for _,v in pairs(t) do table.insert(nt, v[1]) end
  return nt
end

local foods = {}
local ingredients = {}
local allergens = Set:create()

for line in io.lines() do
  local ingredStr, allergensStr = line:match('(.+) %(contains (.+)%)')
  local ingred, aller = wordSplit(ingredStr), wordSplit(allergensStr)

  for _,v in pairs(aller) do
    allergens:add(v)
  end

  for _,i in pairs(ingred) do
    if not ingredients[i] then ingredients[i] = Set:create() end

    for _,a in pairs(aller) do
      ingredients[i]:add(a)
    end
  end

  table.insert(foods, {
    allergens = aller,
    ingredients = ingred
  })
end

allergens = allergens:toTable()

-- Get the intersection of all ingredients that possibly contain a specific allergen
-- Remove the allergen from all ingredients that don't appear in this intersection
for _,a in pairs(allergens) do
  local intersection = Set:create(getAllKeys(ingredients))

  for _,f in pairs(foods) do
    if contains(f.allergens, a) then
      intersection = Set.intersection(intersection, Set:create(f.ingredients))
    end
  end

  for i,s in pairs(ingredients) do
    if not intersection:contains(i) then
      s:remove(a)
    end
  end
end

-- Find the only ingredient in a food that could possibly contain the foods listed allergen
-- By our problem, that ingredient is the *only* ingredient in the whole input that
-- has that allergen, so remove that allergen from the other ingredients possibilities
for _,food in pairs(foods) do
  if #food.allergens > 1 then
    for _,a in pairs(food.allergens) do
      local only = getOnlyPossible(a, food, ingredients)

      if only then
        local onlyASet = Set:create({a})
        ingredients[only] = Set.intersection(ingredients[only], onlyASet)

        for i,s in pairs(ingredients) do
          if i ~= only then
            s:remove(a)
          end
        end
      end
    end
  end
end

local allergenIngredients = {}

for i,s in pairs(ingredients) do
  local t = s:toTable()

  if #t == 1 then
    table.insert(allergenIngredients, { i, t[1] })
  end
end

table.sort(allergenIngredients, function (a, b) return a[2] < b[2] end)

print(table.concat(getAllValues(allergenIngredients), ','))
