const readline = require('readline');

function createMask(line) {
  const mask = {};
  const [_,v] = [...line.match(/mask = ([X01]+)/)];

  for (let i = 0; i < v.length; i++) {
    mask[v.length - 1 - i] = v[i];
  }

  return mask;
}

function applyMask(n, mask) {
  for (const [i,v] of Object.entries(mask)) {
    const bit = 1 << i;
    if (v === '0' && (n & bit) > 0) n -= bit;
    else if (v === '1' && (n & bit) === 0) n += bit;
  }

  return n;
}

let mask = null;
const memory = {};
const rl = readline.createInterface({
  input: process.stdin
});

rl.on('line', (line) => {
  if (line.includes('mask')) {
    mask = createMask(line);
  } else {
    const [_,addr,n] = line.match(/mem\[(\d+)\] = (\d+)/);
    memory[parseInt(addr)] = applyMask(parseInt(n), mask);
  }
});

rl.on('close', () => {
  console.log(Object.values(memory).reduce((a, b) => a + b, 0));
});
