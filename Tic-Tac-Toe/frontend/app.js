
const socket = new WebSocket("ws://localhost:7350");

socket.onopen = () => {
    console.log("WebSocket connected!");
};

socket.onmessage = (event) => {
    const data = JSON.parse(event.data);
    console.log("Game update:", data);

    if (data.winner) {
        alert(`Winner is: ${data.winner}`);
    }
    updateBoard(data.board);
};

function sendMove(row, col) {
    socket.send(JSON.stringify({ row: row, col: col }));
}

function updateBoard(board) {
    const gameDiv = document.getElementById("game");
    gameDiv.innerHTML = "";

    for (let i = 0; i < 3; i++) {
        for (let j = 0; j < 3; j++) {
            const cell = document.createElement("div");
            cell.className = "cell";
            cell.innerText = board[i][j] || "";
            cell.onclick = () => sendMove(i, j);
            gameDiv.appendChild(cell);
        }
    }
}
