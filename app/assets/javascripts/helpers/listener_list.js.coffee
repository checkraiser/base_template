class window.ListenerList
  @listeners = []

  constructor: ()->
    @listeners = []

  add_listener: (listener)->
    @listeners.push(listener)

  notify: (item)->
    for listener in @listeners
      listener(item)

