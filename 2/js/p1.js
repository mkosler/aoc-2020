const fs = require('fs');

let validPasswords = 0;

const file = fs.readFileSync(0, 'utf-8');

for (const match of file.matchAll(/(\d+)-(\d+)\s+(\w):\s+(\w+)/g)) {
  const min = parseInt(match[1]);
  const max = parseInt(match[2]);
  const letter = match[3];
  const password = match[4];

  const count = (password.match(new RegExp(letter, 'g')) || []).length;

  if (min <= count && count <= max) validPasswords++;
}

console.log('validPasswords', validPasswords);
