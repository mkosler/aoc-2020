local function listToString(head)
  local s = ''
  local curr = head

  repeat
    s = s .. curr.value
    curr = curr.next
  until curr.prev.next == head

  return s
end

local function search(v, head, tail)
  local curr = head

  repeat
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

  repeat
    dest = search(v, curr, tail)
    v = v - 1
    if v < min then v = max end
  until dest

  return dest
end

local head = nil
local prev = nil
local min = math.huge
local max = -1

for n in io.read('a'):gmatch('%d') do
  n = tonumber(n)
  if n < min then min = n end
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

local node1 = search(1, head, head.next)
print(listToString(node1))
