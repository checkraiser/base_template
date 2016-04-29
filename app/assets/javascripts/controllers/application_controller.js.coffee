app.controller 'application_controller', ['$scope', '$localStorage', '$sessionStorage', ($scope, $localStorage, $sessionStorage) ->
  $scope.app_user = gon.app_user
  $scope.localStorage = $localStorage
  $scope.sessionStorage = $sessionStorage
]