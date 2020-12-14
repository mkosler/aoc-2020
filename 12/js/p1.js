const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin
});

const ship = {
  x: 0,
  y: 0,
  r: 0
};

rl.on('line', (l) => {
  const action = l[0];
  const magn = parseInt(l.substring(1));

  if (action === 'N') {
    ship.y += magn;
  } else if (action === 'S') {
    ship.y -= magn;
  } else if (action === 'E') {
    ship.x += magn;
  } else if (action === 'W') {
    ship.x -= magn;
  } else if (action === 'L') {
    ship.r = (ship.r + magn) % 360;
  } else if (action === 'R') {
    ship.r = (ship.r - magn) % 360;
  } else if (action === 'F') {
    const rad = (Math.PI / 180.0) * ship.r;
    ship.x += magn * Math.cos(rad);
    ship.y += magn * Math.sin(rad);
  }
});

rl.on('close', () => {
  console.log(Math.abs(ship.x) + Math.abs(ship.y));
});
