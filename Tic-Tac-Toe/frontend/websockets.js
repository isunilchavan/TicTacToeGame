const socket = new WebSocket("ws://localhost:7350");

socket.onopen = () => {
    console.log("WebSocket connected!");
};

socket.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log("Game update:", data);
};

function sendMove(row, col) {
    socket.send(JSON.stringify({ row: row, col: col }));
}
