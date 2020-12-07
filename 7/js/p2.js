const readline = require('readline');

function totalBagCount(bags, current) {
  let sum = 0;

  if (current.children.length === 0) return sum;

  for (const cb of current.children) {
    sum += cb.count + (cb.count * totalBagCount(bags, bags[cb.color]));
  }

  return sum;
}

const targetColor = 'shiny gold';
const bags = {};
const rl = readline.createInterface({
  input: process.stdin
});

rl.on('line', (l) => {
  const b = {
    color: l.match(/^(\w+ \w+)/)[0],
    children: []
  }

  for (const match of l.matchAll(/(\d+) (\w+ \w+) bag[s]?/g)) {
    b.children.push({
      count: parseInt(match[1]),
      color: match[2]
    });
  }

  bags[b.color] = b;
});

rl.on('close', () => {
  console.log('Total bags within:', totalBagCount(bags, bags[targetColor]));
});
