const fs = require('fs');

const groups = fs.readFileSync(0, 'utf-8').split('\n\n')
let sum = 0;

for (const group of groups) {
  const answers = {};

  for (const c of group) {
    if (c !== '\n' && !answers[c]) {
      answers[c] = true;
      sum++;
    }
  }
}

console.log('Sum of counts', sum);
