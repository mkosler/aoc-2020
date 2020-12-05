const fs = require('fs');

function bsp(max, pass, lowKey, highKey) {
  let mid = max / 2;
  let diff = mid / 2;

  for (const c of pass) {
    if (c === lowKey) mid -= diff;
    else if (c == highKey) mid += diff;

    diff /= 2;
  }

  return Math.ceil(mid) - 1;
}

const file = fs.readFileSync(0, 'utf-8');

let maxSeatId = -1;

for (const match of file.matchAll(/([FB]+)([LR]+)/g)) {
  const rowStr = match[1];
  const seatStr = match[2];

  const row = bsp(128, rowStr, 'F', 'B');
  const seat = bsp(8, seatStr, 'L', 'R');

  const id = row * 8 + seat;

  if (id > maxSeatId) maxSeatId = id;
}

console.log(maxSeatId);
