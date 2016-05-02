// transfer click of uploader-placeholder-button to actual uploader button
$(document).on("click", ".upload-button button", function() {
    $(this).parent().find("input[type='file']").first().click();
});

// these are the headers to be used with the angular-file-upload library
function file_upload_headers() {
    var headers = {
        "X-XSRF-TOKEN": $.cookie('XSRF-TOKEN'),
        "X-Requested-With": "XMLHttpRequest",
        "X-CSRF-TOKEN": $('meta[name=csrf-token]').attr('content')
    }
    return headers;
}

function is_image_placeholder_url(url) {
    if(url.starts_with("/assets/image-placeholders/default-")) {
        return true
    }
    return false
}

function asset_url(resource, key) {
    if(is_empty(resource) || is_empty(resource[key])) {
        return gon.assets.image_placholders.default
    }

    var url = resource[key].url
    if(is_image_placeholder_url(url)) {
        return gon.assets.image_placholders.default
    }
    return url + "?" + alphanumeric_underscore(resource.updated_at)
}

function thumb_url(resource, key) {
    if(!key) {
        key = "image"
    }
    if(is_empty(resource) || is_empty(resource[key])) {
        return gon.assets.image_placholders.default
    }
    var url = resource[key].thumb.url
    if(is_image_placeholder_url(url)) {
        return gon.assets.image_placholders.default
    }
    return url + "?" + alphanumeric_underscore(resource.updated_at)
}

function image_url(resource) {
    return asset_url(resource, "image")
}

function file_url(resource) {
    return asset_url(resource, "file")
}