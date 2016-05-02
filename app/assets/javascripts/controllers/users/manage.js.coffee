app.controller 'users_manage_controller', ['$scope', 'User', ($scope, User) ->
  $scope.view_model =
    user: {}
  $scope.User = User
  User.init(gon.users)

  $scope.open_new_user_modal = (e)->
    $scope.view_model.user = {}
    $('.new-user-modal').modal('show')
    return

  $scope.open_settings_user_modal = (user, e)->
    $scope.view_model.user = deep_copy(user)
    $('.settings-user-modal').modal('show')
    return

  $scope.create_user = (e)->
    User.create $scope.view_model.user, {
      button: $(e.currentTarget)
      success_message: "User created!"
      success: (response)->
        $('.new-user-modal').modal('hide')
        return
    }

  $scope.update_user = (e)->
    User.update $scope.view_model.user, {
      button: $(e.currentTarget)
      success_message: "User updated!"
      success: (response)->
        $('.settings-user-modal').modal('hide')
        return
    }
]
