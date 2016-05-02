app.directive 'ngIfVisible', ['$timeout', ($timeout)->
  restrict: 'A'
  transclude: true
  scope: {}
  template: '<ng-transclude ng-if=\'element_is_visible\'></ng-transclude>'
  link: (scope, elem, attrs) ->
    scope.$watch (()-> elem.is ':visible'), ()->
      $timeout ()->
        scope.element_is_visible = elem.is(':visible')
]