local Queue = {}
Queue.__index = Queue

function Queue:create(t)
  local o = {}
  setmetatable(o, Queue)
  o._data = {}
  if t then o._data = t end
  return o
end

function Queue:enqueue(n)
  table.insert(self._data, n)
end

function Queue:dequeue(n)
  return table.remove(self._data, 1)
end

function Queue:count()
  return #self._data
end

function Queue:toTable()
  local t = {}
  for i,v in ipairs(self._data) do t[i] = v end
  return t
end

function Queue:__tostring()
  return table.concat(self._data, ', ')
end

return Queue
