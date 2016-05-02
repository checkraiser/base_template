app.directive "sizeToWindow", ()->
  {
    restrict: "A",
    link: (scope, elem, attrs)->
      min_height_percentage = null
      height_percentage = null
      max_height_percentage = null

      process_height_attribute = (value, css_attribute)->
        available_height = parseInt($(window).height())
        if value
          elem.css(css_attribute, available_height * (value/100.0) + "px")
        else
          elem.css(css_attribute, "auto")

      update_size = ()->
        process_height_attribute(min_height_percentage, "min-height")
        process_height_attribute(height_percentage, "height")
        process_height_attribute(max_height_percentage, "max-height")

      attrs.$observe "minHeightPercentage", (value)->
        min_height_percentage = parseInt(value)
        update_size()

      attrs.$observe "heightPercentage", (value)->
        height_percentage = parseInt(value)
        update_size()

      attrs.$observe "maxHeightPercentage", (value)->
        max_height_percentage = parseInt(value)
        update_size()

      $(window).resize ()->
        update_size()

  }
