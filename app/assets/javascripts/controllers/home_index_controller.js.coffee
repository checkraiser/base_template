app.controller 'home_index_controller', ['$scope', 'EventSystem', ($scope, EventSystem) ->
  $scope.test = gon.test
  EventSystem.init()
  EventSystem.message_created_listeners.add_listener (data)->
    alert(data.data)

]