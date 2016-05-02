$(document).ready(function(){
    var modal_class = get_hash_param("modal-class")
    if(is_empty(modal_class)) {
        return
    }
    $("." + modal_class).modal("show")
})

$(document).on('shown.bs.modal', '.modal', function() {
    $(this).find('[autofocus]').focus();
});