var io = require('socket.io').listen(5001)
var redis = require('redis').createClient('6379', 'redis')
var request = require('request')

var user_clients = {}
var guest_clients = {}

redis.subscribe('new-event')

function get_host_url() {
    var host_url = "https://beta.funnelchat.org"
    if(process.env.NODE_ENV === "development") {
        host_url = "http://localhost:3003/"
    }
    if(process.env.NODE_ENV === "staging") {
        host_url = "https://beta.funnelchat.org/"
    }
    return host_url
}

function register_guest_client(guest_id, guest_token) {
    var host_url = get_host_url()
    // do a POST to server to verify guest
    request.post(
        host_url + 'guest_users/verify_token.json',
        {
            form: {id: guest_id, token: guest_token}
        },
        function (error, response, body) {
            if(error) {
                return
            }
            var guest_id = JSON.parse(body).id
            if(guest_id === null) {
                return
            }
            // initialize user_id key in user_clients if needed
            if(guest_clients[guest_id] === undefined) {
                guest_clients[guest_id] = []
            }
            socket.guest_id = guest_id
            guest_clients[guest_id].push(socket)
        }
    );

    // remove client socket on disconnect
    socket.on('disconnect', function(){
        var guest_id = socket.guest_id
        if(guest_id !== undefined) {
            var sockets = guest_clients[user_id]
            var socket_index = sockets.indexOf(socket)
            if(socket_index !== -1) {
                sockets.splice(socket_index, 1)
            }
        }
    });
}

function register_user_client(user_email, user_token, socket) {
    var host_url = get_host_url()
    // do a POST to server to verify user
    request.post(
        host_url + 'users/verify_token.json',
        {
            form: {email: user_email, token: user_token}
        },
        function (error, response, body) {
            if(error) {
                return
            }
            var user_id = JSON.parse(body).id
            if(user_id === null) {
                return
            }
            // initialize user_id key in user_clients if needed
            if(user_clients[user_id] === undefined) {
                user_clients[user_id] = []
            }
            socket.user_id = user_id
            user_clients[user_id].push(socket)
        }
    );

    // remove client socket on disconnect
    socket.on('disconnect', function(){
        var user_id = socket.user_id
        if(user_id !== undefined) {
            var sockets = user_clients[user_id]
            var socket_index = sockets.indexOf(socket)
            if(socket_index !== -1) {
                sockets.splice(socket_index, 1)
            }
        }
    });
}

io.on('connection', function(socket){
    var socket_query = socket.handshake.query
    var is_guest = socket_query.is_guest

    if(is_guest) {
        var guest_id = socket_query.guest_id
        var guest_token = socket_query.guest_token
        register_guest_client(guest_id, guest_token, socket)
    } else {
        var user_email = socket_query.user_email
        var user_token = socket_query.user_token
        register_user_client(user_email, user_token, socket)
    }
});

function emit_socket_event(clients, ids_to_notify, event) {
    if(!ids_to_notify) {
        return
    }
    for(var i = 0; i < ids_to_notify.length; i++) {
        var id_to_notify = ids_to_notify[i]
        // get all sockets matching id_to_notify
        var sockets = clients[id_to_notify]
        if(sockets === undefined) {
            continue
        }
        for(var j = 0; j < sockets.length; j++) {
            var socket = sockets[j]
            socket.emit(event.type, event.data);
        }
    }
}

// emit event to clients on message received from rails
redis.on('message', function(channel, event_json) {
    var event = JSON.parse(event_json)
    var user_ids = event.user_ids
    var guest_ids = event.guest_ids
    emit_socket_event(user_clients, user_ids, event)
    emit_socket_event(guest_clients, guest_ids, event)
});