'use strict';

const app = require('express')();

const server = require('http').Server(app);

app.get('/', (req, res, next) => {
  res.sendFile(__dirname + '/index.html');
});

// cargar socket.io y configurarlo
const io = require('socket.io')(server);

io.on('connection', (socket) => {
  console.log('COnexión establecida!!');
  socket.on('chat message', (msg) => {
    console.log('message: ' + msg);
    io.emit('chat message', msg);
  });
});
    

server.listen(3000, () => {
  console.log('Arrancado en el puerto 3000');
});