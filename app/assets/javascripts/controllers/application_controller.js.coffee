app.controller 'application_controller', ['$scope', '$window', ($scope, $window) ->
  $scope.app_user = gon.app_user
  $scope.localStorage = $window.localStorage
  $scope.sessionStorage = $window.sessionStorage
]