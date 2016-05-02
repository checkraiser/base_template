function scroll_to_element(target, duration) {
    if($(target).length === 0) {
        return
    }
    if(duration === undefined) {
        duration = 0;
    }
    $('body, html').animate({
        scrollTop: target.offset().top - 20
    }, duration);
}

function scroll_element_to_target(element, target, duration) {
    if(is_empty(duration)) {
        duration = 250;
    }
    var scroll_top = target.position().top - 72
    $(element).animate({ scrollTop: scroll_top }, duration);
}

function scroll_element_to_bottom(element, duration) {
    if(is_empty(duration)) {
        duration = 250;
    }
    if(duration === 0) {
        $(element).scrollTop(element.prop("scrollHeight"))
        return
    }
    $(element).animate({ scrollTop: element.prop("scrollHeight")}, duration);
}