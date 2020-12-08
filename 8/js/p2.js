const readline = require('readline');

function execute(program, ln, acc, probInstr = []) {
  if (ln === program.length) return [acc, false];

  const line = program[ln];

  if (line.called > 0) return [acc, probInstr];

  line.called++;

  if (line.instr === 'nop') {
    probInstr.push(line);
    return execute(program, ln + 1, acc, probInstr);
  } else if (line.instr === 'acc') {
    return execute(program, ln + 1, acc + line.param, probInstr);
  } else {
    probInstr.push(line);
    return execute(program, ln + line.param, acc, probInstr);
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
  const [_, probInstr] = execute(program, 0, 0);

  for (const v of program) v.called = 0;

  for (const v of probInstr) {
    // Deep copy
    const newProgram = JSON.parse(JSON.stringify(program));

    if (v.instr === 'jmp') newProgram[v.ln].instr = 'nop';
    else newProgram[v.ln].instr = 'jmp';

    const [acc, failed] = execute(newProgram, 0, 0);

    if (!failed) {
      console.log('Accumulator', acc);
      return;
    }
  }
});
