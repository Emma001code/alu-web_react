const fs = require('fs');
const path = require('path');

const base = path.join(__dirname);

for (let n = 5; n <= 9; n += 1) {
  const appPath = path.join(base, `task_${n}`, 'dashboard', 'src', 'App', 'App.js');
  if (!fs.existsSync(appPath)) continue;
  let src = fs.readFileSync(appPath, 'utf8');
  src = src.replace(
    /import \{ getLatestNotification \} from "\.\.\/utils\/utils";\r?\n/,
    ''
  );
  src = src.replace(
    /export const listNotificationsInitialState = \[[\s\S]*?\];\r?\n\r?\n/,
    ''
  );
  if (!src.endsWith('\n')) src += '\n';
  fs.writeFileSync(appPath, src);
  console.log(`Cleaned ${appPath}`);

  const shapePath = path.join(
    base,
    `task_${n}`,
    'dashboard',
    'src',
    'Notifications',
    'NotificationItemShape.js'
  );
  if (fs.existsSync(shapePath)) {
    fs.unlinkSync(shapePath);
    console.log(`Removed ${shapePath}`);
  }
}

const courseShape = path.join(
  base,
  'task_7',
  'dashboard',
  'src',
  'CourseList',
  'CourseShape.js'
);
if (fs.existsSync(courseShape)) {
  fs.unlinkSync(courseShape);
  console.log(`Removed ${courseShape}`);
}
