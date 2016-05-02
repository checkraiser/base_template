// use the "interact" library to make items draggable
// works on mobile as well
function make_draggable(identifier, on_end) {
    var restrict_translation_to_parent = {
        restriction: "parent",
        endOnly: true,
        elementRect: { top: 0, left: 0, bottom: 1, right: 1 }
    }
    interact(identifier).draggable({
        inertia: false,
        restrict: restrict_translation_to_parent,
        onmove: translateElement,
        onend: on_end
    });
}

// translate element by updating left/top percentage values
function translateElement (e) {
    var x = $(e.target).position().left + e.dx;
    var y = $(e.target).position().top + e.dy;
    var width = $(e.target).parent().width();
    var height = $(e.target).parent().height();
    var percentX = x / width * 100;
    var percentY = y / height * 100;
    $(e.target).css("left", percentX + "%");
    $(e.target).css("top", percentY + "%");
}