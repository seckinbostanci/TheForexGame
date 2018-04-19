//websocket gateway on 8070
var app = require('http').createServer(handler)
  , io = require('socket.io').listen(app)
  , fs = require('fs');
var mysocket = 0;
app.listen(8070);
function handler (req, res) {
  fs.readFile(__dirname + '/index.html',
  function (err, data) {
    if (err) {
      res.writeHead(500);
      return res.end('Error loading index.html');
    }
    res.writeHead(200);
    res.end(data);
  });
}
io.sockets.on('connection', function (socket) {
  console.log('index.html connected'); 
  mysocket = socket;
});


// net.socket ile backend'e bağlanıp dataları web socket'e attığımız kısım +
var net = require('net');
var client = new net.Socket();

client.connect(1007, '192.168.8.109', function () {
  console.log('Connected');
//   client.write('Hello, server! Love, Client.');
});

client.on('data', function (data) {
    console.log(data);
    
    //web sockete attığımız kısım.
    if (mysocket != 0) {
        mysocket.emit('field', "" + data);
        mysocket.broadcast.emit('field', "" + data);
    }
    //client.destroy(); // kill client after server's response
});

client.on('close', function () {
  console.log('Connection closed');
});
// net.socket ile backend'e bağlanıp dataları web socket'e attığımız kısım -