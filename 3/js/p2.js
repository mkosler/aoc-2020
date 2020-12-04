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
  let answer = 1;

  const velocities = [
    { dr: 1, dc: 1 },
    { dr: 1, dc: 3 },
    { dr: 1, dc: 5 },
    { dr: 1, dc: 7 },
    { dr: 2, dc: 1 },
  ];

  for (const velocity of velocities) {
    const pos = { r: 0, c: 0 };
    let treeCount = 0;

    while (pos.r < height) {
      pos.c = (pos.c + velocity.dc) % width;
      pos.r = pos.r + velocity.dr;

      if (pos.r >= height) {
        break;
      }

      if (map[pos.r][pos.c]) treeCount++;
    }

    answer *= treeCount;
  }

  console.log('answer', answer);
});
