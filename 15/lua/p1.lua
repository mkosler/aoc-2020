local MemoryGame = {}
MemoryGame.__index = MemoryGame

function MemoryGame:create()
  local o = {}
  setmetatable(o, MemoryGame)
  o.numbers = {}
  o.lastNumber = nil
  o.turn = 0
  return o
end

function MemoryGame:add(n)
  self.lastNumber = n
  self.turn = self.turn + 1
  if not self:exists(n) then self.numbers[n] = {} end
  table.insert(self.numbers[n], self.turn)
end

function MemoryGame:exists(n)
  return self.numbers[n] ~= nil
end

function MemoryGame:spokenCount(n)
  if not self:exists(n) then return 0 end
  return #self.numbers[n]
end

function MemoryGame:getLastTwoTurns(n)
  local nTurns = self.numbers[n]
  return nTurns[#nTurns], nTurns[#nTurns - 1]
end

local input = io.read('a')
local game = MemoryGame:create()

for n in input:gmatch('%d+') do
  game:add(tonumber(n))
end

while game.turn < 2020 do
  if game:spokenCount(game.lastNumber) < 2 then
    game:add(0)
  else
    local t1, t2 = game:getLastTwoTurns(game.lastNumber)
    game:add(t1 - t2)
  end
end

print(game.lastNumber)
