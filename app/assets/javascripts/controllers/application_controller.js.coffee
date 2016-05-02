app.controller 'application_controller', ['$scope', '$localStorage', '$sessionStorage', 'Api', 'ApiFeedback', ($scope, $localStorage, $sessionStorage,
  Api, ApiFeedback) ->
  $scope.app_user = gon.app_user
  window.app_user = $scope.app_user
  $scope.localStorage = $localStorage
  $scope.sessionStorage = $sessionStorage
  $scope.app_data = gon.app_data
  window.app_data = $scope.app_data
  init_with_utility_functions($scope)
  $scope.main_overlay = {visible: false, text: "", sub_text: ""}

  $scope.main_overlay.show = (text = "", sub_text = "")->
    $scope.main_overlay.text = text
    $scope.main_overlay.sub_text = sub_text
    $(".main-overlay").show()
    $(".main-overlay .overlay").fadeIn(100)
    $scope.main_overlay.visible = true
    return
  $scope.main_overlay.hide = ()->
    $(".main-overlay").delay(100).hide(10)
    $(".main-overlay .overlay").fadeOut(100)
    $scope.main_overlay.visible = false
    return

  ######################################################
  # deletion notification functions
  ######################################################
  $scope.deletion_notification = {visible: false, item_name: "", is_plural: false}
  $scope.deletion_notification.show = (item_name, is_plural = false)->
    $scope.deletion_notification.item_name = item_name
    $scope.deletion_notification.is_plural = is_plural
    $(".deletion-notification").show()
    $(".deletion-notification .overlay").fadeIn(100)
    $scope.deletion_notification.visible = true
    return

  $scope.deletion_notification.hide = ()->
    $(".deletion-notification").delay(100).hide(10)
    $(".deletion-notification .overlay").fadeOut(100)
    $scope.deletion_notification.visible = false
    return
]