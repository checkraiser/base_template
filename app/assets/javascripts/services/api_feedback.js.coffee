app.factory 'ApiFeedback', ['$timeout', ($timeout) ->
  api_feedback = {success_messages: []}

  api_feedback.clear_errors = ()->
    api_feedback.error_message = "";
    api_feedback.errors = []
    api_feedback.modal_error_message = "";
    api_feedback.modal_errors = []

  api_feedback.show_success_message = (message = "Success!", delay = 2000)->
    api_feedback.success_messages.push(message)
    $timeout ()->
      api_feedback.success_messages.splice(0, 1)
    , delay

  # transform errors from a key-value array, to a listing
  parse_errors = (data_errors, error_key_replacements)->
    return if is_empty(data_errors)
    errors = []
    for error_key, error_detail_arr of data_errors
      for error_detail in error_detail_arr
        # replace error key if there is a custom replacement for it
        if !is_empty(error_key_replacements) && !is_empty(error_key_replacements[error_key])
          error_key = error_key_replacements[error_key]

        error_str = error_key.humanize() + " " + error_detail

        # some error messages start with You, don't print the error_key in this case
        if(error_detail.starts_with("You "))
          error_str = error_detail

        errors.push(error_str)
    return errors

  api_feedback.render_errors = (data = {}, error_key_replacements, render_modal_errors) ->
    if render_modal_errors
      api_feedback.modal_error_message = data.message
      api_feedback.modal_errors = parse_errors(data.errors, error_key_replacements)
      $timeout ()->
        # scroll the currently opened modal to the top
        $(".modal.in").first().scrollTop(0)
      return

    api_feedback.error_message = data.message
    api_feedback.errors = parse_errors(data.errors, error_key_replacements)

    # scroll to the alert element
    $timeout ()->
      scroll_to_element($(".alert-danger").first())

  return api_feedback
]
