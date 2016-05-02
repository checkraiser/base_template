/*
 * fit element to image:
 * used to automatically resize elements to their sibling image
 * how to use:
 * 1. add the class "fit-to-image" to the element which you want to automatically resize
 * 2. add the class "fit-to-image-target" to the image you want the element to resize to
 * 3. Note: these two elements must be siblings in DOM
 *
 * Resizing occurs once after image initially loads, and subsequently on window resize
 * If the image size changes for other events, the resize_all_fit_to_image_elements() function
 * needs to be manually called
 */
function fit_element_to_image() {
    var element = $(this).siblings(".fit-to-image").first();
    element.width($(this).width());
    element.height($(this).height());
}

function resize_all_fit_to_image_elements() {
    $(".fit-to-image-target").each(fit_element_to_image);
}

$(window).resize(function() {
    resize_all_fit_to_image_elements();
});

$(document).ready(function() {
    $(".fit-to-image-target").load(fit_element_to_image);
});

/*
 * get image size:
 * the "callback" function is called with the image's width/height once image is loaded
 */
function get_image_size(image_src, callback) {
    var img = new Image();

    img.onload = function() {
        var height = img.height;
        var width = img.width;
        callback(width, height);
    }

    img.src = image_src;
}

/*
 * get scaled background dimensions:
 * returns the background dimensions given an image's width and height,
 * as well as the x, y values to focus on. This is used as the css background values.
 *
 * for example, this is used to show a portion of a visualization that a visualization tag is on
 * in this case, the visualization image's width and height is passed in
 * the visualization tag's x and y values (in percentage, relative to the visualization's top-left corner)
 * are also passed in.
 * scale refers to the zoom amount
 */
function get_scaled_background_dimensions(image_width, image_height, x, y, scale) {
    var background_dimensions = {}
    background_dimensions.width = scale
    background_dimensions.height = scale / image_width * image_height

    // additional calculations to account for the way css background-position is calculated
    var border_scale = (scale - 100) * 10
    var border_x = border_scale / (background_dimensions.width - 100)
    var border_y = border_scale / (background_dimensions.height - 100)
    var actual_width = 100 + 2 * border_x
    var actual_height = 100 + 2 * border_y

    // assign corrected tag x, y values
    background_dimensions.x = (parseFloat(x) / 100) * actual_width - border_x
    background_dimensions.y = (parseFloat(y) / 100) * actual_height - border_y

    return background_dimensions
}