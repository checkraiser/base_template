app.controller 'home_index_controller', ['$scope', ($scope) ->
  $scope.current_account = gon.current_account
  $scope.current_user = gon.current_user
  $scope.treedata = [
    {
      label: "I need you"
      children: [
        {label: "I need you 2"}
      ]
    },
    {
      label: "I love you"
      children: [
        {label: "I love you 3"}
      ]
    }

  ]
  $scope.showSelected = (sel)->
    $scope.selectedNode = sel
]