import "./index.css";

const dashboard = document.createElement("div");
dashboard.className = "dashboard";

const logo = document.createElement("div");
logo.id = "logo";
dashboard.appendChild(logo);

const title = document.createElement("h1");
title.textContent = "Holberton Dashboard";
dashboard.appendChild(title);

const subtitle = document.createElement("p");
subtitle.textContent = "Dashboard data for the students";
dashboard.appendChild(subtitle);

document.getElementById("root").appendChild(dashboard);
