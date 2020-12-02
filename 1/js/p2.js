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
      for (const c of expenses) {
        if (a !== b && a !== c && b !== c && a + b + c == 2020) {
          console.log(a, b, c, a * b * c);
          return;
        }
      }
    }
  }
});
