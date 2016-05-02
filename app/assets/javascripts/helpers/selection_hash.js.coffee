class window.SelectionHash
  constructor: ()->
    @hash = {}

  select_multiple: (item_keys)->
    for item_key in item_keys
      @select(item_key)

  unselect_multiple: (item_keys)->
    for item_key in item_keys
      @unselect(item_key)

  select: (item_key)->
    @hash[item_key] = true

  unselect: (item_key)->
    @hash[item_key] = false

  is_selected: (item_key)->
    @hash[item_key]

  unselect_all: ()->
    @hash = {}