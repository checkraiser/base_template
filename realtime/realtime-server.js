var fs = require('fs');
var path = require('path');
var config = require('js-yaml').safeLoad(fs.readFileSync(path.join(__dirname, '../config') +'/server_settings.yml', 'utf8'));;
var env = process.env.NODE_ENV;
var redis_host = config[env].redis_host;
var realtime_host_name = config[env].realtime_host_name
console.log(redis_host);
var redis = require('redis').createClient('6379', redis_host);
redis.subscribe('message-created');
redis.subscribe('contacts-loaded');
var io = require('socket.io').listen(5002, {origins: '*:*'});

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