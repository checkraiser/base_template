app.controller 'home_index_controller', ['$scope', 'EventSystem', ($scope, EventSystem) ->
  $scope.messages = []
  $scope.contacts = []

  EventSystem.message_created_listeners.add_listener (data)->
    $scope.$apply $scope.messages.push(data.data)

  EventSystem.contacts_loaded_listeners.add_listener (data)->
    $scope.$apply $scope.contacts.push data.data

  EventSystem.init()
]