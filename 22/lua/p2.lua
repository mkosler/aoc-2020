local Queue = require 'lua/queue'

local players = {}

for line in io.lines() do
  if line:find('Player') then
    table.insert(players, Queue:create())
  elseif line ~= '' then
    players[#players]:enqueue(tonumber(line))
  end
end

local function combat(deck1, deck2)
  local rounds = {}

  while deck1:count() > 0 and deck2:count() > 0 do
    local r = string.format('p1:%s p2:%s', deck1, deck2)
    if rounds[r] then
      return true
    else
      rounds[r] = true
    end

    local p1 = deck1:dequeue()
    local p2 = deck2:dequeue()

    if p1 <= deck1:count() and p2 <= deck2:count() then
      local subDeck1 = Queue:create({ table.unpack(deck1:toTable(), 1, p1) })
      local subDeck2 = Queue:create({ table.unpack(deck2:toTable(), 1, p2) })

      if combat(subDeck1, subDeck2) then
        deck1:enqueue(p1)
        deck1:enqueue(p2)
      else
        deck2:enqueue(p2)
        deck2:enqueue(p1)
      end
    elseif p1 > p2 then
      deck1:enqueue(p1)
      deck1:enqueue(p2)
    else
      deck2:enqueue(p2)
      deck2:enqueue(p1)
    end
  end

  return deck2:count() == 0
end

combat(players[1], players[2])

local winningDeck = nil
if players[2]:count() == 0 then
  winningDeck = players[1]:toTable()
else
  winningDeck = players[2]:toTable()
end

local score = 0
for i,v in ipairs(winningDeck) do
  score = score + (v * (#winningDeck - (i - 1)))
end

print(score)
