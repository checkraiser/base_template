$(document).ready(function(){
    $(".tutorial-button").click(function(){
        $('body').chardinJs('start')
    })
})

function set_overlay_instruction(element, instruction, position) {
    element.first().attr("data-intro", instruction)
    if(!is_empty(position)) {
        element.first().attr("data-position", position)
    }
}