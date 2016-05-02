app.controller 'application_controller', ['$scope', '$localStorage', '$sessionStorage', ($scope, $localStorage, $sessionStorage) ->
  $scope.app_user = gon.app_user
  window.app_user = $scope.app_user
  $scope.localStorage = $localStorage
  $scope.sessionStorage = $sessionStorage
  $scope.app_data = gon.app_data
  window.app_data = $scope.app_data
  init_with_utility_functions($scope)
]