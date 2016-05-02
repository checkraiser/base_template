app.controller 'api_feedback_index_controller', ['$scope', 'ApiFeedback', ($scope, ApiFeedback) ->
  $scope.ApiFeedback = ApiFeedback
]