app.factory 'BaseModel', ['Api', (Api) ->
  self = {}

  self.new = (resource_name, base_url, sort_by)->
    model = {}
    model.index = []
    model.refresh_in_progress = false

    model.sort = ()->
      if sort_by
        model.index.sort(keys_sort(sort_by))

    model.init_options_data = (resource, options)->
      if !options.data
        options.data = {}
        options.data[resource_name] = resource

    model.get = (resource, options)->
      on_success = options.success
      options.success = (response)->
        on_success(response) if on_success

      Api.get base_url + "/" + resource.id, options

    model.create = (resource, options = {})->
      model.init_options_data(resource, options)
      on_success = options.success
      options.success = (response)->
        model.index.push(response)
        model.sort()
        on_success(response) if on_success

      Api.post base_url, options

    model.update = (resource, options = {}, replace_entirely = false)->
      model.init_options_data(resource, options)
      on_success = options.success
      options.success = (response)->
        model.index.update_by_id(response, replace_entirely)
        model.sort()
        on_success(response) if on_success

      Api.put base_url + "/" + resource.id, options

    model.destroy = (resource, options = {})->
      on_success = options.success
      options.success = (response)->
        model.index.remove_by_id(resource.id)
        on_success(response) if on_success

      Api.delete base_url + "/" + resource.id, options

    model.refresh = (options = {})->
      model.refresh_in_progress = true
      success = options.success
      options.success = (response)->
        model.index = response
        success(response) if success

      on_response = options.on_response
      options.on_response = (response)->
        model.refresh_in_progress = false
        on_response(response) if on_response

      Api.get base_url + ".json", options

    return model

  return self
]
