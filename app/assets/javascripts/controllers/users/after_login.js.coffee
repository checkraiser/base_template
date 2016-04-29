app.controller 'users_after_login_controller', ['$scope', ($scope) ->
  next_url = gon.after_initialization_url || "/"
  # prevent redirection to this page(users/after_login)
  if next_url.indexOf("users/after_login") > 0
    next_url = "/"
  window.location = next_url
]