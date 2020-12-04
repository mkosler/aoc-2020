const readline = require('readline');

const map = [];

const rl = readline.createInterface({
  input: process.stdin
});

rl.on('line', (l) => {
  const row = [];

  for (const c of l) {
    row.push(c == '#');
  }

  map.push(row);
});

rl.on('close', () => {
  const width = map[0].length;
  const height = map.length;

  const velocity = { dr: 1, dc: 3 };
  const pos = { r: 0, c: 0 };
  let treeCount = 0;

  while (pos.r < height) {
    pos.c = (pos.c + velocity.dc) % width;
    pos.r = pos.r + velocity.dr;

    if (pos.r >= height) {
      console.log('treeCount', treeCount);
      return;
    }

    if (map[pos.r][pos.c]) treeCount++;
  }
});
