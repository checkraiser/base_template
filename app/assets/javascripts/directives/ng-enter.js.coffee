app.directive 'ngEnter', ()->
  return (scope, element, attrs)->
    element.bind "keydown keypress", (e)->
      if e.which == 13
        scope.$apply ()->
          scope.$eval(attrs.ngEnter)
        e.preventDefault()