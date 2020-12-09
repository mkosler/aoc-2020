const readline = require('readline');

class Queue {
  constructor(capacity) {
    this.capacity = capacity;
    this._data = [];
  }

  enqueue(v) {
    this._data.push(v);

    if (this.capacity < this._data.length) {
      this._data.shift();
    }
  }

  test(v) {
    for (const a of this._data) {
      for (const b of this._data) {
        if (a !== b && a + b == v) return true;
      }
    }

    return false;
  }

  get length() {
    return this._data.length;
  }
}

if (process.argv.length < 3) {
  console.error('missing PREAMBLE_SIZE');
  return;
}

const PREAMBLE_SIZE = parseInt(process.argv[2]);
const xq = new Queue(PREAMBLE_SIZE);

const rl = readline.createInterface({
  input: process.stdin
});

rl.on('line', (l) => {
  const v = parseInt(l);

  if (xq.length == PREAMBLE_SIZE && !xq.test(v)) {
    console.log('First failure', v);
    process.exit(1);
  }

  xq.enqueue(v);
});
