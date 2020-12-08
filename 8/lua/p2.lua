local function deepCopy(t)
  local ot = type(t)
  local c

  if ot == 'table' then
    c = {}

    for ok, ov in next, t, nil do
      c[deepCopy(ok)] = deepCopy(ov)
    end

    setmetatable(c, deepCopy(getmetatable(t)))
  else
    c = t
  end

  return c
end

local function execute(program, ln, acc, probInstr)
  probInstr = probInstr or {}

  if ln > #program then
    return acc, false
  end

  local line = program[ln]

  if line.called > 0 then
    return acc, probInstr
  end

  line.called = line.called + 1

  if line.instr == 'nop' then
    table.insert(probInstr, line)
    return execute(program, ln + 1, acc, probInstr)
  elseif line.instr == 'acc' then
    return execute(program, ln + 1, acc + line.param, probInstr)
  elseif line.instr == 'jmp' then
    table.insert(probInstr, line)
    return execute(program, ln + line.param, acc, probInstr)
  else
    error('unknown instruction')
  end
end

local program = {}

for line in io.lines() do
  local instr, param = line:match('(%a+) ([+-]%d+)')

  table.insert(program, { 
    ln = #program + 1,
    line = line,
    instr = instr,
    param = tonumber(param),
    called = 0
  })
end

local _, probInstr = execute(program, 1, 0)

for _,v in pairs(probInstr) do
  local newProgram = deepCopy(program)

  -- Reset called count
  for _,v in pairs(newProgram) do
    v.called = 0
  end

  if v.instr == 'jmp' then
    newProgram[v.ln].instr = 'nop'
  else
    newProgram[v.ln].instr = 'jmp'
  end

  local acc, failed = execute(newProgram, 1, 0)

  if not failed then
    print('Accumulator', acc)
    return
  end
end
