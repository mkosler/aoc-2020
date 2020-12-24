local function listToString(head, count)
  local s = ''
  local curr = head

  repeat
    s = s .. curr.value .. '|'
    curr = curr.next
    count = count - 1
  until curr.prev.next == head or count == 0

  return s
end

local function search(v, head, tail, ending)
  local curr = head

  repeat
    -- if ending then print('checking') end
    if curr.value == v then
      return curr
    end
    curr = curr.prev
  until curr == tail

  return nil
end

-- Search backwards until tail
local function getDestination(curr, tail, min, max)
  local dest = nil
  local v = curr.value - 1
  if v < min then v = max end

  local notInPickedUp = false
  repeat
    if v ~= tail.value and v ~= tail.prev.value and v ~= tail.prev.prev.value then
      notInPickedUp = true
      break
    end
    v = v - 1
    if v < min then v = max end
  until notInPickedUp

  return search(v, curr, tail)
end

local head = nil
local prev = nil
local min = 1
local max = -1

for n in io.read('a'):gmatch('%d') do
  n = tonumber(n)
  if n > max then max = n end

  local node = {
    value = n
  }

  if head == nil then
    head = node
  else
    node.prev = prev
    prev.next = node
  end

  prev = node
end

-- Add the extra million
for i = max + 1, 1000000 do
  local node = { value = i }

  node.prev = prev
  prev.next = node

  prev = node
end

max = 1000000

-- Create circular link
head.prev = prev
prev.next = head

local rounds = tonumber(arg[1])

local curr = head
for i = 1, rounds do
  local pickupHead = curr.next -- pickupHead, pickupHead.next, pickupHead.next.next
  local pickupTail = pickupHead.next.next

  local dest = getDestination(curr, pickupTail, min, max)

  pickupHead.prev.next = pickupTail.next
  pickupTail.next.prev = pickupHead.prev

  pickupTail.next = dest.next
  pickupTail.next.prev = pickupTail

  pickupHead.prev = dest
  dest.next = pickupHead

  curr = curr.next
end

print(head.value, head.next.value, head.prev.value, head.prev.prev.value)
local node1 = search(1, head, head.next, true)
print(listToString(node1, 10))
