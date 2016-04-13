app.factory 'EventSystem', [ ()->
  self =
    user_socket: null
    notification_created_listeners: new ListenerList()
    message_created_listeners: new ListenerList()

  self.init = ()->
    console.log "abc"
    url = window.location.hostname

    self.user_socket = io.connect(url+":5001")
    console.log url

    self.user_socket.on "message-created", (data)->
      console.log JSON.stringify(data.data)
      self.message_created_listeners.notify(data)


  return self
]
