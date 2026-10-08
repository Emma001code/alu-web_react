const fs = require('fs');
const path = require('path');

const base = path.join(__dirname);
const lock = path.join(base, 'task_0', 'dashboard', 'package-lock.json');

for (let n = 0; n <= 3; n += 1) {
  const dest = path.join(base, `task_${n}`, 'dashboard', 'package-lock.json');
  fs.copyFileSync(lock, dest);
  console.log(`Copied lockfile to task_${n}`);
}
