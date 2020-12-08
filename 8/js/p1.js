const readline = require('readline');

function execute(program, ln, acc) {
  const line = program[ln];

  if (line.called > 0) return acc;

  line.called++;

  if (line.instr === 'nop') {
    return execute(program, ln + 1, acc);
  } else if (line.instr === 'acc') {
    return execute(program, ln + 1, acc + line.param);
  } else {
    return execute(program, ln + line.param, acc);
  }
}

const rl = readline.createInterface({
  input: process.stdin
});

const program = [];

rl.on('line', (l) => {
  const [_, instr, param] = [...l.match(/(\w+) ([+-]\d+)/)];

  program.push({
    ln: program.length,
    line: l,
    instr: instr,
    param: parseInt(param),
    called: 0
  })
});

rl.on('close', () => {
  console.log('Accumulator', execute(program, 0, 0))
});
