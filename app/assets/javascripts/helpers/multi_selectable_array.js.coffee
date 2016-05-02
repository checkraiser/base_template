# multi-selectable array
# used to manage arrays can have multiple items selected
class window.MultiSelectableArray
  constructor: (array)->
    @set_array(array)

  select: (index)->
    return if @selected_indexes[index]
    @selected_indexes[index] = true
    item = @array[index]
    @selected.push(item)

  unselect: (index)->
    return if !@selected_indexes[index]
    @selected_indexes[index] = false
    item = @array[index]
    @selected.remove(item)

  toggle: (index)->
    if @selected_indexes[index]
      @unselect(index)
    else
      @select(index)

  select_all: ()->
    i = 0
    while i < @array.length
      @select(i)
      i++

  unselect_all: ()->
    i = 0
    while i < @array.length
      @unselect(i)
      i++

  is_selected: (index)->
    return @selected_indexes[index]

  set_array: (array)->
    @array = array
    @selected = []
    @selected_indexes = {}

  selected_count: ()->
    @selected.length