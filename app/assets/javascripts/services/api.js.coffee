# for all api functions, the options allowed are:
# button - specify the button identifier, button("loading") and button("reset") will be called for it
# success_message - on success, this message will be shown to user
# success - custom success callback, will be called even if success_message is specified
# error - custom error callback, additionally, $scope.render_errors will be called as well
# on_response - custom callback, will be called regardless if request was successful or had an error
# error_key_replacements - replacements for error keys, e.g. {"supplier_type" : "type"},
# would change the error message from e.g. "Supplier Type cannot be blank" to "Type cannot be blank"
app.factory 'Api', ['$http', '$timeout', 'ApiFeedback', ($http, $timeout, ApiFeedback) ->
  api = {}
  api.post = (url, options) ->
    api.perform_request($http.post, url, options)

  api.put = (url, options) ->
    api.perform_request($http.put, url, options)

  api.get = (url, options) ->
    api.perform_request($http.get, url, options)

  api.delete = (url, options) ->
    api.perform_request($http.delete, url, options)

  api.process_request = (http_function, url, data = {}, options, success, error, on_response)->
    http_function(url, data)
    .success (response)->
      options.before_success(response) if options.before_success
      success(response) if success
      options.after_success(response) if options.after_success
      on_response(response) if on_response
      options.after_response(response) if options.after_response
    .error (response)->
      error(response) if error
      on_response(response) if on_response
      options.after_response(response) if options.after_response

  api.perform_request = (http_function, url, options) ->
    ApiFeedback.clear_errors()

    # init options and data as needed
    options ?= {}
    data = options.data || {}

    # assign button variable
    button = null
    if options.button && (typeof options.button.button == "function")
      button = options.button

    success_message = options.success_message
    success_message_delay = options.success_message_delay || 2000

    # assign callback functions
    success = options.success
    error = options.error
    on_response = options.on_response

    # error key replacements allows changing of error key display values
    # e.g. if error_key_replacements = {"supplier_type" : "type"}
    # the error message would change from "Supplier Type cannot be blank" to "Type cannot be blank"
    error_key_replacements = options.error_key_replacements

    # if disable_button is true, disable the button on_response
    disable_button = options.disable_button

    # if true the main window errors will not be shown
    # modal_errors will be assigned instead
    render_modal_errors = options.render_modal_errors

    # set the button as loading if it is not null
    if button != null
      button.button("loading")

    api.process_request http_function, url, data, options
      # on success
    , (response)->
      success(response) if success
      ApiFeedback.show_success_message(success_message, success_message_delay) if success_message
      # on error
    , (response)->
      error(response) if error
      ApiFeedback.render_errors(response, error_key_replacements, render_modal_errors)
      # on response
    , (response)->
      on_response(response) if on_response
      if button != null
        button.button("reset")
        if disable_button
          $timeout ()->
            button.attr('disabled','disabled')

  return api
]