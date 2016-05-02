app.directive 'ngApplyOnHoverOrClick', ['$timeout', ($timeout)->
  restrict: 'A'
  scope: {}
  link: (scope, elem, attrs) ->
    elem.bind 'mouseenter', ->
      $timeout ()->
        scope.$apply()

    elem.bind 'mouseleave', ->
      $timeout ()->
        scope.$apply()

    elem.bind 'click', ->
      $timeout ()->
        scope.$apply()
]