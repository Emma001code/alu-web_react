const fs = require('fs');
const path = require('path');

const base = path.join(__dirname);

for (let n = 0; n <= 9; n += 1) {
  const pkgPath = path.join(base, `task_${n}`, 'dashboard', 'package.json');
  if (!fs.existsSync(pkgPath)) continue;
  const pkg = JSON.parse(fs.readFileSync(pkgPath, 'utf8'));

  pkg.dependencies = pkg.dependencies || {};
  Object.assign(pkg.dependencies, {
    immutable: '^4.3.6',
    normalizr: '^3.6.2',
    redux: '^4.2.1',
    'redux-thunk': '^2.4.2',
    'react-redux': '^7.2.9',
    'node-fetch': '^2.6.7',
    react: '16.14.0',
    'react-dom': '16.14.0',
  });
  if (n >= 8) {
    pkg.dependencies.reselect = '^4.1.8';
  }

  pkg.devDependencies = pkg.devDependencies || {};
  Object.assign(pkg.devDependencies, {
    'enzyme-adapter-react-16': '^1.15.7',
    'identity-obj-proxy': '^3.0.0',
    '@babel/plugin-proposal-class-properties': '^7.18.6',
    'react-test-renderer': '16.14.0',
  });
  delete pkg.devDependencies['babel-plugin-styled-components'];

  fs.writeFileSync(pkgPath, JSON.stringify(pkg, null, 2) + '\n');
  fs.writeFileSync(
    path.join(base, `task_${n}`, 'dashboard', '.npmrc'),
    'legacy-peer-deps=true\n'
  );
  console.log(`Updated ${pkgPath}`);
}
