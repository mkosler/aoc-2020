local function execute(program, ln, acc)
  local line = program[ln]

  if line.called > 0 then return acc end

  line.called = line.called + 1

  if line.instr == 'nop' then
    return execute(program, ln + 1, acc)
  elseif line.instr == 'acc' then
    return execute(program, ln + 1, acc + line.param)
  elseif line.instr == 'jmp' then
    return execute(program, ln + line.param, acc)
  else
    error('unknown instruction')
  end
end

local program = {}

for line in io.lines() do
  local instr, param = line:match('(%a+) ([+-]%d+)')

  table.insert(program, { instr = instr, param = tonumber(param), called = 0 })
end

print('Accumulator on first repeat', execute(program, 1, 0))
