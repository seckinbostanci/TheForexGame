var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var mysocket = 0;

app.get('/', function(req, res){
  res.sendFile(__dirname + '/index.html');
});

io.on('connection', function(socket){
    console.log("ID'si : " + socket.id + " olan client ile socket bağlantısı başlatıldı..");
    socket.on("auth",function(data){
        if(data =='123'){
            mysocket = socket;
        }else{
            socket.disconnect(true);
        }
    });
    socket.on('disconnect', function(){
        console.log("ID'si : " + socket.id + " olan client ile socket bağlantısı bitirildi..");
    });
  });

http.listen(3000, function(){
  console.log('Web Yayını Başlatıldı PORT:3000');
});

// net.socket ile backend'e bağlanıp dataları web socket'e attığımız kısım +
var net = require('net');
var client = new net.Socket();

client.connect(1007, '192.168.8.109', function () {
  console.log('Connected');
//   client.write('Hello, server! Love, Client.');
});

client.on('data', function (data) {
    //console.log(data);
    var msg = data;
    msg = msg.slice(0, -1);
    //web sockete attığımız kısım.
    if (mysocket != 0) {
        mysocket.emit('data', "" + msg);
        mysocket.broadcast.emit('data', "" + msg);
    }
    //client.destroy(); // kill client after server's response
});

client.on('close', function () {
  console.log('Connection closed');
});
// net.socket ile backend'e bağlanıp dataları web socket'e attığımız kısım -