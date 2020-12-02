const fs = require('fs');

let validPasswords = 0;

const file = fs.readFileSync(0, 'utf-8');

for (const match of file.matchAll(/(\d+)-(\d+)\s+(\w):\s+(\w+)/g)) {
  let count = 0;

  const p1 = parseInt(match[1]);
  const p2 = parseInt(match[2]);
  const letter = match[3];
  const password = match[4];

  if (password[p1 - 1] == letter) count++;
  if (password[p2 - 1] == letter) count++;

  if (count == 1) validPasswords++;
}

console.log('validPasswords', validPasswords);
