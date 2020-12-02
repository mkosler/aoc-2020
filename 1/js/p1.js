const readline = require('readline');

const expenses = [];

const rl = readline.createInterface({
  input: process.stdin,
});

rl.on('line', (l) => {
  expenses.push(parseInt(l));
});

rl.on('close', () => {
  for (const a of expenses) {
    for (const b of expenses) {
      if (a !== b && a + b == 2020) {
        console.log(a, b, a * b);
        return;
      }
    }
  }
});
