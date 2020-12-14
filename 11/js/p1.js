const readline = require('readline');

const FLOOR = '.';
const EMPTY = 'L';
const OCCUPIED = '#';

function countOccupiedNeighbors(grid, r, c) {
  const bounds = {
    left: c - 1 < 0 ? 0 : c - 1,
    right: c + 1 > grid[r].length - 1 ? grid[r].length - 1 : c + 1,
    top: r - 1 < 0 ? 0 : r - 1,
    bottom: r + 1 > grid.length - 1 ? grid.length - 1 : r + 1
  };

  let count = 0;
  for (let nr = bounds.top; nr <= bounds.bottom; nr++) {
    for (let nc = bounds.left; nc <= bounds.right; nc++) {
      if (!(nr === r && nc === c) && grid[nr][nc] === OCCUPIED) count++;
    }
  }

  return count;
}

function applyRules(grid) {
  const current = JSON.parse(JSON.stringify(grid));
  let change = 0;

  for (let r = 0; r < current.length; r++) {
    for (let c = 0; c < current[r].length; c++) {
      const count = countOccupiedNeighbors(current, r, c);

      if (current[r][c] === EMPTY && count === 0) {
        change++;
        grid[r][c] = OCCUPIED;
      }

      if (current[r][c] === OCCUPIED && count >= 4) {
        change++;
        grid[r][c] = EMPTY;
      }
    }
  }

  return change;
}

const rl = readline.createInterface({
  input: process.stdin
});

const grid = [];

rl.on('line', (line) => {
  grid.push([...line.trim()]);
});

rl.on('close', () => {
  while (applyRules(grid) > 0) {}

  console.log(`Occupied: ${grid.flat().reduce((a, v) => (v === OCCUPIED ? a + 1 : a), 0)}`);
});
