local Queue = {}
Queue.__index = Queue

function Queue:create(capacity)
  local o = {}
  setmetatable(o, Queue)
  o.capacity = capacity
  o.data = {}
  return o
end

function Queue:enqueue(v)
  table.insert(self.data, v)

  if self.capacity < #self.data then
    table.remove(self.data, 1)
  end
end

function Queue:test(v)
  for _,a in pairs(self.data) do
    for _,b in pairs(self.data) do
      if a ~= b and a + b == v then return true end
    end
  end

  return false
end

function Queue:__len()
  return #self.data
end

function Queue:__tostring()
  return table.concat(self.data, ', ')
end

---

local PREAMBLE_SIZE = 25

local xmasQueue = Queue:create(PREAMBLE_SIZE)

for line in io.lines() do
  local v = tonumber(line)

  if #xmasQueue == xmasQueue.capacity then
    if not xmasQueue:test(v) then
      print('First failure', v)
      return
    end
  end

  xmasQueue:enqueue(v)
end
