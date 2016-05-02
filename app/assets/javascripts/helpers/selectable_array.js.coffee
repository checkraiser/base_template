# selectable array
# used to manage arrays which need to keep track of selectable elements
# convenience functions such as has_next, select_next, has_prev, select_prev are also provided
class window.SelectableArray

  constructor: (array = [])->
    @selection_changed_listeners = new ListenerList()
    @selected = {}
    @selected_index = -1
    @hovered_index = -1
    @infinite = false
    @set_array(array)

  update_item_by_id: (item)->
    index = 0
    for array_item, i in @array
      if(array_item.id == item.id)
        index = i
        break

    @array[index] = item
    @set_selected(index)

  remove_by_id_and_unselect: (item)->
    @array.remove_by_id(item)
    if @array.length == 0
      @selected = {}
      @selection_changed_listeners.notify(@selected)
      return

    index = @selected_index
    index-- if index == @array.length
    @set_selected(index)

  on_selection_changed: (listener)->
    @selection_changed_listeners.add_listener(listener)

  set_array: (array = [], reset_index = true)->
    @array = array
    if !is_empty(array) && reset_index
      @set_selected(0)
    if is_empty(array)
      @clear_selection()

  set_selected: (index)->
    @selected_index = index
    return if is_empty(index) || index < 0
    @selected = @array[index]
    @selection_changed_listeners.notify(@selected)

  clear_selection: ()->
    @selected_index = -1
    @selected = {}

  set_selected_by_id: (id)->
    for array_item, i in @array
      if(array_item.id == id)
        @set_selected(i)
        break

  is_selected: (index)->
    return index == @selected_index

  has_next: ()->
    return true if @infinite
    return @selected_index < @array.length - 1

  select_next: ()->
    return if !@has_next()
    next_index = @selected_index + 1
    if next_index >= @array.length
      next_index = 0
    @set_selected(next_index)

  has_prev: ()->
    return true if @infinite
    return @selected_index > 0

  select_prev: ()->
    return if !@has_prev()
    prev_index = @selected_index - 1
    if prev_index < 0
      prev_index = @array.length - 1
    @set_selected(prev_index)

  append_and_select: (item)->
    @array.push(item)
    @set_selected(@array.length - 1)

  set_hovered: (index)->
    @hovered_index = index

  is_hovered: (index)->
    return index == @hovered_index

  set_infinite: (infinite)->
    @infinite = infinite