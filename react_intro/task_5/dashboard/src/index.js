import React from "react";
import ReactDOM from "react-dom";
import "./index.css";

const App = () => (
  <div className="dashboard">
    <h1>Holberton Dashboard</h1>
    <p>Dashboard data for the students</p>
  </div>
);

ReactDOM.render(<App />, document.getElementById("root"));
