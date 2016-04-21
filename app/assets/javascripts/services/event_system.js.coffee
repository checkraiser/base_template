app.factory 'EventSystem', [ ()->
  self =
    user_socket: null
    message_created_listeners: new ListenerList()
    contacts_loaded_listeners: new ListenerList()

  self.init = ()->
    url = window.location.origin

    self.user_socket = io.connect(url)
    console.log url

    self.user_socket.on "message-created", (data)->
      console.log data
      self.message_created_listeners.notify(data)

    self.user_socket.on "contacts-loaded", (data)->
      console.log data
      self.contacts_loaded_listeners.notify(data)


  return self
]
