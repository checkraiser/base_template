app.directive "isolatedScroll", ()->
  restrict: "A",
  link: (scope, elem, attrs)->
    $(elem).addClass("isolated-scroll")
    elem.bind "mousewheel", (e) ->
      if(this.scrollHeight <= this.offsetHeight)
        return
      e.preventDefault()
      this.scrollTop -= (e.deltaY * e.deltaFactor)