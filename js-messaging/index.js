const websocket = require("ws");

// Create WebSocket Server
const port = 8081;
const wss = new websocket.Server({
  port: port,
});

console.log("Running WebSocket Server on Port:", port);
wss.on("connection", (ws) => {
  console.log("New client connected!");

  ws.on("message", (data) => {
    console.log("Got data from client", data);
  });

  ws.on("close", () => {
    console.log("Client has disconnected");
  });

  ws.on("error", () => {
    console.log("Something went wrong!");
  });

  // Peridically sends data
  let count = 1;
  setInterval(() => {
    ws.send(`HALO: ${count}`);
    count++;
  }, 1500);
});
