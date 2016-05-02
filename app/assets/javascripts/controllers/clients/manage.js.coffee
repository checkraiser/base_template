app.controller 'clients_manage_controller', ['$scope', 'Client', ($scope, Client) ->
  $scope.view_model =
    client: {}
  $scope.Client = Client
  Client.init(gon.clients)

  $scope.open_new_client_modal = (e)->
    $scope.view_model.client = {}
    $('.new-client-modal').modal('show')
    return

  $scope.open_settings_client_modal = (client, e)->
    $scope.view_model.client = deep_copy(client)
    $('.settings-client-modal').modal('show')
    return

  $scope.create_client = (e)->
    Client.create $scope.view_model.client, {
      button: $(e.currentTarget)
      success_message: "Client created!"
      success: (response)->
        $('.new-client-modal').modal('hide')
        return
    }

  $scope.update_client = (e)->
    Client.update $scope.view_model.client, {
      button: $(e.currentTarget)
      success_message: "Client updated!"
      success: (response)->
        $('.settings-client-modal').modal('hide')
        return
    }
]