// the below is needed because of an odd issue in Google Chrome
// which causes FontAwesome icons to render as squares at times
// to use this, if you want a lightbulb icon: .fa.fa-lightbulb-o
// but it shows as a square
// write it as .fa.fa-lightbulb-o-temp.fa-temp instead
// the below code will loop through all fa-temp elements
// and change it to .fa.fa-lightbulb-o-temp.fa-temp.fa-lightbulb
// this solves the Google Chrome issue
$(document).ready(function() {
    $(".fa-temp").each(function() {
        var classnames = $(this).attr("class").split(/\s+/)
        for(var i = 0; i < classnames.length; i++) {
            var classname = classnames[i]
            if(classname == "fa-temp") {
                continue
            }
            if(classname.indexOf("fa-") == 0) {
                var new_classname = classname.substr(0, classname.length - "-temp".length)
                $(this).addClass(new_classname)
            }
        }
    })
})