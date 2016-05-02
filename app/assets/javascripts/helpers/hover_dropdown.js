$(document).on("mouseenter", ".dropdown.hover-dropdown", function(){
    $(this).addClass("open")
})

$(document).on("mouseleave", ".dropdown.hover-dropdown", function(){
    var dropdown = $(this)
    if(dropdown.hasClass("clicked")) {
        setTimeout(function (){
            dropdown.removeClass("clicked")
        }, 300)
        return
    }
    dropdown.removeClass("open")
})

$(document).on("mousedown", ".dropdown.hover-dropdown", function(){
    $(this).addClass("clicked")
})