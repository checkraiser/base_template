/*
 * custom popover:
 * default bootstrap only provides focus, click, manual as triggers to close a popup
 * many times we want to close a popover when anything outside of the popover is clicked
 * but not when elements inside the popover is clicked
 * this is what custom-popover does
 * how to use:
 * 1. add "popover-parent" to the element which is the popover target
 * 2. add "popover" as a child of this parent, add "bottom" or other to indicate popover positioning
 * 3. add "arrow" as a child of "popover" to show the popover arrow
 * 4. add the class "custom-popover" to this popover
 * 5. add "popover-content" and the content you want to show
 *
 * if you need to manually close the custom-popover, call close_custom_popovers
 */
$(document).on("click", ".popover-parent", function(e){
    var popover = $(this).parent().children(".custom-popover").first();
    if(!$(e.target).hasClass("popover-parent") && !$(e.target).hasClass("popover-icon")) {
        return;
    }
    if(popover.hasClass("visible")) {
        popover.removeClass("visible");
        return;
    }
    popover.addClass("visible");
});

function close_custom_popovers() {
    $(".custom-popover").removeClass("visible");
}

$(document).click(function(e) {
    if(is_empty($(e.target).closest(".popover-parent"))) {
        close_custom_popovers();
        return;
    }
});