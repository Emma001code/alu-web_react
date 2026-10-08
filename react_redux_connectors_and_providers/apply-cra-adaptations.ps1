$proj = "c:\projects\alu-web_react\react_redux_connectors_and_providers"

$indexUiOnly = @'
import React from "react";
import ReactDOM from "react-dom";
import { createStore } from "redux";
import { Provider } from "react-redux";
import App from "./App/App";
import uiReducer, { initialState } from "./reducers/uiReducer";
import { Map } from "immutable";

const store = createStore(uiReducer, Map(initialState));

ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>,
  document.getElementById("root")
);
'@

$indexUiThunk = @'
import React from "react";
import ReactDOM from "react-dom";
import { createStore, applyMiddleware } from "redux";
import { Provider } from "react-redux";
import thunk from "redux-thunk";
import App from "./App/App";
import uiReducer, { initialState } from "./reducers/uiReducer";
import { Map } from "immutable";

const store = createStore(uiReducer, Map(initialState), applyMiddleware(thunk));

ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>,
  document.getElementById("root")
);
'@

$indexUiDevTools = @'
import React from "react";
import ReactDOM from "react-dom";
import { createStore, applyMiddleware, compose } from "redux";
import { Provider } from "react-redux";
import thunk from "redux-thunk";
import App from "./App/App";
import uiReducer, { initialState } from "./reducers/uiReducer";
import { Map } from "immutable";

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

const store = createStore(
  uiReducer,
  Map(initialState),
  composeEnhancers(applyMiddleware(thunk))
);

ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>,
  document.getElementById("root")
);
'@

$indexRoot = @'
import React from "react";
import ReactDOM from "react-dom";
import { createStore, applyMiddleware, compose, combineReducers } from "redux";
import { Provider } from "react-redux";
import thunk from "redux-thunk";
import App from "./App/App";
import rootReducer, { initialState } from "./reducers/rootReducer";
import reportWebVitals from "./reportWebVitals";

const composeEnhancers = window.__REDUX_DEVTOOLS_EXTENSION_COMPOSE__ || compose;

const store = createStore(
  combineReducers(rootReducer),
  initialState,
  composeEnhancers(applyMiddleware(thunk))
);

ReactDOM.render(
  <React.StrictMode>
    <Provider store={store}>
      <App />
    </Provider>
  </React.StrictMode>,
  document.getElementById("root")
);

reportWebVitals();
'@

$jestConfig = @'
module.exports = {
  moduleNameMapper: {
    "\\.(jpg|jpeg|png|gif|eot|otf|webp|svg|ttf|woff|woff2|mp4|webm|wav|mp3|m4a|aac|oga)$": "<rootDir>/file-mock.js",
    "\\.(css|less|sass|scss)$": "identity-obj-proxy",
  },
  testEnvironment: "jsdom",
  setupFilesAfterEnv: ["<rootDir>/src/setupTests.js"],
};
'@

$babelrc = @'
{
  "presets": [
    "@babel/preset-env",
    "@babel/preset-react"
  ]
}
'@

$setupTests = @'
import "@testing-library/jest-dom";
import Enzyme from "enzyme";
import Adapter from "enzyme-adapter-react-16";

Enzyme.configure({ adapter: new Adapter() });
'@

0..9 | ForEach-Object {
  $dash = Join-Path $proj "task_$($_)\dashboard"
  if ($_ -le 1) { $index = $indexUiOnly }
  elseif ($_ -eq 2) { $index = $indexUiThunk }
  elseif ($_ -eq 3) { $index = $indexUiDevTools }
  else { $index = $indexRoot }

  Set-Content -Path (Join-Path $dash "src\index.js") -Value ($index + "`n") -NoNewline
  Set-Content -Path (Join-Path $dash "jest.config.js") -Value ($jestConfig + "`n") -NoNewline
  Set-Content -Path (Join-Path $dash ".babelrc") -Value ($babelrc + "`n") -NoNewline
  Set-Content -Path (Join-Path $dash "src\setupTests.js") -Value ($setupTests + "`n") -NoNewline
  $babelConfig = Join-Path $dash "babel.config.js"
  if (Test-Path $babelConfig) { Remove-Item $babelConfig -Force }
  if (Test-Path (Join-Path $dash ".babellrc")) { Remove-Item (Join-Path $dash ".babellrc") -Force }
}

Write-Host "CRA adaptations applied."
