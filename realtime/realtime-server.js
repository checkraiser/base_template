var redis = require('redis').createClient('6379', '127.17.0.1')
redis.subscribe('message-created');
redis.subscribe('contacts-loaded');
var io = require('socket.io').listen(5002);

io.on('connection', function(socket){
    console.log('connected socket')
    socket.on('disconnect', function(){
        console.log('client disconnected')
        socket.disconnect();
    });
});

redis.on('message', function(channel, message){
    var info = JSON.parse(message);
    io.sockets.emit(channel, info);
    console.log('emit '+ channel);
});