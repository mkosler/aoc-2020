const readline = require('readline');

const FLOOR = '.';
const EMPTY = 'L';
const OCCUPIED = '#';

function testNearestNeighbor(grid, cr, cc, dr, dc) {
  if (cr < 0 || cc < 0 || cr > grid.length || cc > grid[0].length) return false;
  if (grid[cr][cc] !== FLOOR) return grid[cr][cc] === OCCUPIED;
  return testNearestNeighbor(grid, cr + dr, cc + dc, dr, dc);
}

function countOccupiedNeighbors(grid, r, c) {
  let count = 0;

  for (let dr = -1; dr <= 1; dr++) {
    for (let dc = -1; dc <= 1; dc++) {
      if (!(dr === 0 && dc === 0) && testNearestNeighbor(grid, r + dr, c + dc, dr, dc)) count++;
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
