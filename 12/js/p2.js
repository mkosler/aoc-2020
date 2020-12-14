const readline = require('readline');

const rl = readline.createInterface({
  input: process.stdin
});

const ship = {
  x: 0,
  y: 0,
};

const waypoint = {
  x: 10,
  y: 1
};

rl.on('line', (l) => {
  const action = l[0];
  let magn = parseInt(l.substring(1));

  if (action === 'N') {
    waypoint.y += magn;
  } else if (action === 'S') {
    waypoint.y -= magn;
  } else if (action === 'E') {
    waypoint.x += magn;
  } else if (action === 'W') {
    waypoint.x -= magn;
  } else if (action === 'L' || action === 'R') {
    if (action === 'R') magn = -magn;

    const rad = (Math.PI / 180.0) * magn;
    const nx = waypoint.x * Math.cos(rad) - waypoint.y * Math.sin(rad);
    const ny = waypoint.x * Math.sin(rad) + waypoint.y * Math.cos(rad);
    waypoint.x = nx;
    waypoint.y = ny;
  } else if (action === 'F') {
    ship.x += magn * waypoint.x;
    ship.y += magn * waypoint.y;
  }
});

rl.on('close', () => {
  console.log(Math.abs(ship.x) + Math.abs(ship.y));
});
