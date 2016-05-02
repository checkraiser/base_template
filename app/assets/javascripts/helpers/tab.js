$(document).ready(function() {
    if(!$(".url-persistent-tabs")[0]) {
        return
    }
    var current_tab = get_hash_param("#tab")
    if(is_empty(current_tab)) {
        current_tab = $(".url-persistent-tabs li a").first().attr("href").substr(1)
    }
    $(".url-persistent-tabs a[href='#" + current_tab + "']").first().tab("show")
})

$(document).on("click", ".url-persistent-tabs a", function(){
    if(!$(this).attr("href"))
        return
    var tab = $(this).attr("href").substr(1)
    set_hash_param("#tab", tab)
})