app.directive "modalNotifications", ['$templateCache', ($templateCache)->
  return {
  restrict: "A",
  templateUrl: "components/shared/modal_notifications.html"
  bindToController: true
  transclude: false
  controllerAs : 'self'
  scope: {
  }
  controller: ['ApiFeedback', (ApiFeedback)->
    self = this
    self.is_empty = is_empty
    self.error_message = ()-> ApiFeedback.modal_error_message
    self.errors = ()-> ApiFeedback.modal_errors
  ]
  }
]
