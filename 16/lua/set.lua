local Set = {}
Set.__index = Set

function Set:create(t)
  local o = {}
  setmetatable(o, Set)
  o._data = {}

  if t then
    for _,n in ipairs(t) do o._data[n] = true end
  end

  return o
end

function Set:add(n)
  self._data[n] = true
end

function Set:remove(n)
  self._data[n] = nil
end

function Set:toTable()
  local t = {}
  for k,_ in pairs(self._data) do table.insert(t, k) end
  return t
end

function Set.union(a, b)
  local t = Set:create()
  for k,_ in pairs(a._data) do t._data[k] = true end
  for k,_ in pairs(b._data) do t._data[k] = true end
  return t
end

function Set.intersection(a, b)
  local t = Set:create()
  for k,_ in pairs(a._data) do t._data[k] = b._data[k] end
  return t
end

return Set
