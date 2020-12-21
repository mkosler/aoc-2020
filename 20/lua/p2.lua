-- local function edgeToNumber(edge)
--   return edge:gsub('[.#]', function (c)
--     if c == '#' then
--       return '1'
--     else
--       return '0'
--     end
--   end)
-- end

-- local function createEdges(pic, width, height)
--   local edges = {}

--   local top = edgeToNumber(pic:sub(1, width))
--   -- print('top', top, tonumber(top, 2), tonumber(top:reverse(), 2))
--   edges.top = { tonumber(top, 2), tonumber(top:reverse(), 2) }

--   local rightS = ''
--   for i = 1, height do
--     rightS = rightS .. pic:sub(i * width + (i - 1), i * width + (i - 1))
--   end
--   local right = edgeToNumber(rightS)
--   -- print('right', right, tonumber(right, 2), tonumber(right:reverse(), 2))
--   edges.right = { tonumber(right, 2), tonumber(right:reverse(), 2) }

--   local bottom = edgeToNumber(pic:sub(-width):reverse())
--   -- print('bottom', bottom, tonumber(bottom, 2), tonumber(bottom:reverse(), 2))
--   edges.bottom = { tonumber(bottom, 2), tonumber(bottom:reverse(), 2) }

--   local leftS = ''
--   for i = 1, height do
--     leftS = leftS .. pic:sub(i + ((i - 1) * width), i + ((i - 1) * width))
--   end
--   leftS = leftS:reverse()
--   local left = edgeToNumber(leftS)
--   -- print('left', left, tonumber(left, 2), tonumber(left:reverse(), 2))
--   edges.left = { tonumber(left, 2), tonumber(left:reverse(), 2) }

--   return edges
-- end

local function createOrientations(pic, width, height)
  local top = pic:sub(1, width)
  local ftop = top:reverse()

  local right = ''
  for i = 1, height do
    right = right .. pic:sub(i * width + (i - 1), i * width + (i - 1))
  end
  local fright = right:reverse()

  local bottom = pic:sub(-width):reverse()
  local fbottom = bottom:reverse()

  local fleft = ''
  for i = 1, height do
    fleft = fleft .. pic:sub(i + ((i - 1) * width), i + ((i - 1) * width))
  end
  local left = fleft:reverse()

  return {
    '0' = { top, right, bottom, left },
    '90' = { left, top, right, bottom },
    '180' = { bottom, left, top, right },
    '270' = { right, bottom, left, top },
    'f0' = { ftop, fright, fbottom, fleft },
    'f90' = { fleft, ftop, fright, fbottom },
    'f180' = { fbottom, fleft, ftop, fright },
    'f270' = { fright, fbottom, fleft, ftop },
  }
end

local function isNeighbor(a, b)
  for _,ao in pairs(a.orientations) do
    for bon,bo in pairs(b.orientations) do
    end
  end
end

local function getNeighbors(tiles, a)
  local neighbors = {}
  for _,b in pairs(tiles) do
    if a ~= b and isNeighbor(a, b) then
      table.insert(neighbors, b)
    end
  end
  return neighbors
end

local function trimBorder(t)
  local npic = ''

  for i = 0, #t.pic - 1 do
    local mod = i % (t.width + 1)
    if i > t.width + 1 and mod > 0 and mod < t.width - 1 and i < t.width * t.height then
      npic = npic .. t.pic:sub(i + 1, i + 1)
    end
    if mod == 0 then npic = npic .. '\n' end
  end

  t.pic = npic:sub(3, -2) -- trim some janky newlines
  t.width = t.width - 2
  t.height = t.height - 2
end

local tiles = {}

local file = io.read('a'):gsub('\n\n', '|'):sub(1, -2)

for t in file:gmatch('[^|]+') do
  local id, pic = t:match('Tile (%d+):\n([.#\n]+)')
  local width = pic:find('\n') - 1
  local height = (#pic + 1) / (width + 1)

  table.insert(tiles, {
    id = tonumber(id),
    pic = pic,
    width = width,
    height = height,
    orientations = createOrientations(pic, width, height)
  })
end

local corner = nil
for _,t in pairs(tiles) do
  t.neighbors = getNeighbors(tiles, t)
  if #t.neighbors == 2 then corner = t end
end

-- trim borders
for _,t in pairs(tiles) do
  trimBorder(t)
end
