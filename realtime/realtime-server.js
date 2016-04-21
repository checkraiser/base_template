var redis = require('redis').createClient('6379', 'redis')
redis.subscribe('message-created');
redis.subscribe('contacts-loaded');
var io = require('socket.io').listen(process.env.PORT || 5001);
io.configure(function() {
    io.set('origins', '*:*');
});
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