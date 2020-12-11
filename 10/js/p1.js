const readline = require('readline');

const adapters = [0];

const rl = readline.createInterface({
  input: process.stdin
});

rl.on('line', (line) => {
  adapters.push(parseInt(line));
  console.log(line, adapters[adapters.length - 1]);
});

rl.on('close', () => {
  adapters.sort();

  adapters.push(adapters[adapters.length - 1] + 3);

  const counts = [0, 0, 0];

  for (let i = 0; i < adapters.length - 1; i++) {
    const diff = adapters[i + 1] - adapters[i];
    counts[diff - 1]++;
  }

  console.log(`1J: ${counts[0]}, 3J: ${counts[2]}, Answer: ${counts[0] * counts[2]}`);
});
