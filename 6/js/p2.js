const fs = require('fs');

const file = fs.readFileSync(0, 'utf-8');
const groups = file.substring(0, file.length - 1).split('\n\n');
let sum = 0;

for (const group of groups) {
  const answers = {};
  const pplCount = (group.match(/\n/g) || []).length + 1;

  for (const match of group.matchAll(/\w/g)) {
    let c = match[0];

    if (!answers[c]) answers[c] = 0;

    answers[c]++;
  }

  for (const a of Object.values(answers)) {
    if (a === pplCount) sum++;
  }
}

console.log('Sum of counts', sum);
