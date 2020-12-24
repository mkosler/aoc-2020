local Queue = require 'lua/queue'

local players = {}

for line in io.lines() do
  if line:find('Player') then
    table.insert(players, Queue:create())
  elseif line ~= '' then
    players[#players]:enqueue(tonumber(line))
  end
end

while players[1]:count() > 0 and players[2]:count() > 0 do
  local p1 = players[1]:dequeue()
  local p2 = players[2]:dequeue()

  if p1 > p2 then
    players[1]:enqueue(p1)
    players[1]:enqueue(p2)
  else
    players[2]:enqueue(p2)
    players[2]:enqueue(p1)
  end
end

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
