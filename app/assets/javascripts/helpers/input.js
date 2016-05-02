$(document).on("keypress", ".blur-on-keypress-enter", function(e){
    if(e.which === 13 && !e.shiftKey) {
        $(this).blur();
    }
});

/* track value change:
 * this is used to track whether an input's value has changed, typically the use case is so
 * that an update call to api will only be done if the input value has changed
 * it works by keeping track of the initial value on focus, this value is stored as an attribute
 * on the element "data-prev-value", whether the input has changed is
 * stored in a second attribute as "data-input-changed"
 */
$(document).on("focus", ".track-value-change", function(){
    $(this).attr("data-prev-value", $(this).val());
    $(this).attr("data-input-changed", false);
});

$(document).on("change", ".track-value-change", function(){
    var input_changed = false;
    if($(this).val() !== $(this).attr("data-prev-value")) {
        input_changed = true;
    }
    $(this).attr("data-input-changed", input_changed);
});

/* select text on input click with .select-all-on-click class */
$(document).on("click", ".select-all-on-click", function() {
    if($(this).is(":focus")) {
        return;
    }
    $(this).focus();
    $(this).select();
});