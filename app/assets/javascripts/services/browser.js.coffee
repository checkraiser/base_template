app.factory 'Browser', [() ->
  self = {}

  ######################################################
  # storage key listener functions
  ######################################################
  # these functions implement a method to communicate between a single user's browser's windows/tabs
  # because of the way local storage works, if window A and window B subscribes to event X,
  # and window A calls notify for event X, listeners in window A will not be notified
  # instead only listeners in other browsers windows, such as window B, will be notified
  self.init_key = (target_key)->
    if is_empty(localStorage.getItem(target_key)) || isNaN(localStorage.getItem(target_key))
      localStorage.setItem(target_key, 0)

  self.on = (target_key, listener)->
    self.init_key(target_key)

    # bind listener to key change
    $(window).bind 'storage', (e)->
      if e.originalEvent.key == target_key
        listener()

  # update the key's value, this will notify all listeners
  self.notify = (target_key)->
    self.init_key(target_key)
    target_key_value = parseInt(localStorage.getItem(target_key))
    localStorage.setItem(target_key, target_key_value+1)

  return self
]