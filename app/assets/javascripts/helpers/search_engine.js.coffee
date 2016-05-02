class window.SearchEngine
  constructor: (array = [], config)->
    @config = config
    @keys = config.keys
    @set(array)

  split_string: (string)->
    string.split(/[^A-Za-z0-9]/)

  set: (array)->
    @original_array = array
    @searchable_items = []
    return if is_empty(array)
    for item in array
      searchable_item = {source_item: item}
      searchable_words = []
      for key in @keys
        continue if (!item[key] || item[key].length == 0)
        word_arr = @split_string(item[key])
        for word in word_arr
          searchable_words.push(word.toLowerCase())
      searchable_item.searchable_words = searchable_words
      @searchable_items.push(searchable_item)

  # example:
  # string_arr_1 = ["Apexis", "Apex", "Pte", "Ltd"]
  # string_arr_2 = ["ape", "pte"]
  # the score returned would be 3
  get_string_score: (string_arr_1, string_arr_2)->
    score = 0
    for string_1 in string_arr_1
      continue if string_1.length == 0
      for string_2 in string_arr_2
        continue if string_2.length == 0
        if(string_1.indexOf(string_2) == 0)
          score += 1
    return score

  get_item_score: (item, keyword_arr)->
    return @get_string_score(item.searchable_words, keyword_arr)

  search: (keywords, limit = null)->
    if is_empty(keywords)
      if @config.if_blank_query == "return_all"
        return @original_array
      return []

    keyword_arr = []
    for keyword in @split_string(keywords)
      keyword_arr.push(keyword.toLowerCase())

    result_items = []
    for searchable_item in @searchable_items
      searchable_item.score = @get_item_score(searchable_item, keyword_arr)
      if searchable_item.score > 0
        result_items.push(searchable_item)

    result_items.sort(key_sort("score"))
    result_items.reverse()
    results = []
    for result_item in result_items
      results.push(result_item.source_item)

    return results.slice(0, limit) if limit

    return results