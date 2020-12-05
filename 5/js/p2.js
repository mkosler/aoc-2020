const fs = require('fs');

function bsp(max, pass, lowKey, highKey) {
  let mid = max / 2;
  let diff = mid / 2;

  for (const c of pass) {
    if (c === lowKey) mid -= diff;
    else if (c === highKey) mid += diff;

    diff /= 2;
  }

  return Math.ceil(mid) - 1;
}

const file = fs.readFileSync(0, 'utf-8');

const seats = {};

for (const match of file.matchAll(/([FB]+)([LR]+)/g)) {
  const rowStr = match[1];
  const seatStr = match[2];

  const row = bsp(128, rowStr, 'F', 'B');
  const seat = bsp(8, seatStr, 'L', 'R');

  const id = row * 8 + seat;

  seats[id] = true;
}

for (const id of Object.keys(seats).map(o => parseInt(o))) {
  if (!seats[id + 1] && seats[id + 2]) {
    console.log(id + 1);
    return;
  }
}
