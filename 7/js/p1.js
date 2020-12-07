const readline = require('readline');

function bagSearch(bags, current, targetColor) {
  if (current.color === targetColor) return true;
  if (current.children.length === 0) return false;

  for (const cb of current.children) {
    if (bagSearch(bags, bags[cb.color], targetColor)) return true;
  }

  return false;
}

const targetColor = 'shiny gold';
let count = 0;
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
  for (const [color, bag] of Object.entries(bags)) {
    if (color !== targetColor && bagSearch(bags, bag, targetColor)) count++;
  }

  console.log('Total possible outermost bags:', count);
});
