# searchable array
# provides efficient search for an array of objects by an object's key
class window.SearchableArray

  constructor: (array = [], config)->
    @search_engine = new SearchEngine(array, config)

  set_array: (array = [])->
    @search_engine.set(array)

  get_matches: (query)->
    return @search_engine.search(query)
