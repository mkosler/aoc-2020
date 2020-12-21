local function edgeToNumber(edge)
  return edge:gsub('[.#]', function (c)
    if c == '#' then
      return '1'
    else
      return '0'
    end
  end)
end

local function createEdges(pic, width, height)
  local edges = {}

  local top = edgeToNumber(pic:sub(1, width))
  table.insert(edges, { tonumber(top, 2), tonumber(top:reverse(), 2) })

  local rightS = ''
  for i = 1, height do
    rightS = rightS .. pic:sub(i * width + (i - 1), i * width + (i - 1))
  end
  local right = edgeToNumber(rightS)
  table.insert(edges, { tonumber(right, 2), tonumber(right:reverse(), 2) })

  local bottom = edgeToNumber(pic:sub(-width):reverse())
  table.insert(edges, { tonumber(bottom, 2), tonumber(bottom:reverse(), 2) })

  local leftS = ''
  for i = 1, height do
    leftS = leftS .. pic:sub(i + ((i - 1) * width), i + ((i - 1) * width))
  end
  leftS = leftS:reverse()
  local left = edgeToNumber(leftS)
  table.insert(edges, { tonumber(left, 2), tonumber(left:reverse(), 2) })

  return edges
end

local function hasMatchingEdge(aEdges, bEdges)
  for _,ae in pairs(aEdges) do
    for _,be in pairs(bEdges) do
      if ae[1] == be[1] or ae[1] == be[2] or ae[2] == be[1] or ae[2] == be[2] then return true end
    end
  end

  return false
end

local function getNeighbors(tiles, a)
  local neighbors = {}
  for _,b in pairs(tiles) do
    if a ~= b and hasMatchingEdge(a.edges, b.edges) then
      table.insert(neighbors, b)
    end
  end
  return neighbors
end

local tiles = {}

local file = io.read('a'):gsub('\n\n', '|'):sub(1, -2)

for t in file:gmatch('[^|]+') do
  local id, pic = t:match('Tile (%d+):\n([.#\n]+)')
  local width = pic:find('\n') - 1
  local height = (#pic + 1) / (width + 1)

  local edges = createEdges(pic, width, height)

  table.insert(tiles, {
    id = tonumber(id),
    pic = pic,
    width = width,
    height = height,
    edges = edges
  })
end

local product = 1

for _,t in pairs(tiles) do
  local neighbors = getNeighbors(tiles, t)
  if #neighbors == 2 then product = product * t.id end
end

print(product)
