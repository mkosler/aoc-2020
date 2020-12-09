local Queue = {}
Queue.__index = Queue

function Queue:create(capacity)
  local o = {}
  setmetatable(o, Queue)
  o.capacity = capacity
  o.data = {}
  o.allData = {}
  return o
end

function Queue:enqueue(v)
  table.insert(self.data, v)
  table.insert(self.allData, v)

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

  return false, #self.allData
end

function Queue:failedRange(v)
  for i = 1, #self.allData do
    local sum = 0

    for j = i, #self.allData do
      sum = sum + self.allData[j]

      if sum == v then
        return { table.unpack(self.allData, i, j) }
      elseif sum > v then
        break
      end
    end
  end
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
    local passed, pos = xmasQueue:test(v)

    if not passed then
      print(string.format('First failure: %d @ %d', v, pos))

      local fr = xmasQueue:failedRange(v)
      table.sort(fr)

      print(string.format('Contiguous range: [%s], Exploit: %d', table.concat(fr, ' '), fr[1] + fr[#fr]))
    end
  end

  xmasQueue:enqueue(v)
end
