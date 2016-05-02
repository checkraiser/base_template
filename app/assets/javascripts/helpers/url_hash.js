// gets the value of a particular hash parameter
// for example, if url is http://localhost:3001/products#tag=24
// get_hash_param_value('#tag') will return 24
function get_hash_param(key, default_value) {
    if(is_empty(default_value)) {
        default_value = "";
    }
    var hash_key = key + "="
    var url = window.location.toString();
    // find start index of hash
    var hash_start_index = url.indexOf(hash_key);
    if(hash_start_index == -1) {
        if(!is_empty(default_value)) {
            set_hash_param(key, default_value);
        }
        return default_value;
    }

    var value_start_index = hash_start_index + hash_key.length;

    // find the next index of next '#' symbol, use url length if there is no next symbol
    var value_end_index = url.indexOf("#", value_start_index);
    if(value_end_index == -1) {
        value_end_index = url.length;
    }
    var param =  url.substring(value_start_index, value_end_index);
    return decodeURIComponent(param);
}

// adds the hash parameter if it does not exist
// replaces the hash parameter's with the new value if it already exists
function set_hash_param(key, value) {
    var url = window.location.toString();
    if(is_empty(value)) {
        value = "";
    }

    if(url.indexOf(key + "=") == -1) {
        url += key + "=" + encodeURIComponent(value);
        window.location = url;
        return;
    }
    replace_hash_param(key, value);
}

// replace an existing hash parameter's value with a new value
function replace_hash_param(key, value) {
    key += "=";
    var url = window.location.toString();
    var hash_start_index = url.indexOf(key);
    var value_start_index = hash_start_index + key.length;
    // find the next index of next '#' symbol, use url length if there is no next symbol
    var value_end_index = url.indexOf("#", value_start_index);
    if(value_end_index == -1) {
        value_end_index = url.length;
    }

    var start_url_component = url.substr(0, hash_start_index);
    var end_url_component = url.substr(value_end_index);

    window.location = start_url_component + key + value + end_url_component
}


function remove_hash_param(key){
    var url = window.location.toString();
    var hash_start_index = url.indexOf(key);
    var next_start_index = url.indexOf('#',hash_start_index+1);
    var start_url_component = url.substr(0,hash_start_index);
    if (next_start_index === -1){
        window.location = start_url_component ;
    }else{
        var end_url_component = url.substr(next_start_index);
        window.location = start_url_component + end_url_component;
    }
}
