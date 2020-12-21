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

local function printIngredients(is)
  for i,s in pairs(is) do
    local t = s:toTable()
    print(i, string.format('(%s)', table.concat(t, ' ')))
  end
end

local function printFoods(foods, ingredients)
  for _,f in pairs(foods) do
    print(table.concat(f.allergens, ' '))
    for _,i in pairs(f.ingredients) do
      print('\t', i, string.format('(%s)', table.concat(ingredients[i]:toTable(), ' ')))
    end
  end
end

local function getAllKeys(t)
  local nt = {}
  for k,_ in pairs(t) do
    table.insert(nt, k)
  end
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

-- Finally, go through our ingredients table and pull all the ingredients with no possible
-- allergens, and count the number of times they appear in the food
local noAllergenIngredients = {}

for i,s in pairs(ingredients) do
  local t = s:toTable()

  if #t == 0 then
    table.insert(noAllergenIngredients, i)
  end
end

local count = 0

for _,f in pairs(foods) do
  for _,i in pairs(f.ingredients) do
    for _,ii in pairs(noAllergenIngredients) do
      if i == ii then count = count + 1 end
    end
  end
end

print(table.concat(noAllergenIngredients, ' '), count)
