function inflected_text(count, singular_string, without_count) {
    if(is_empty(count)) {
        count = 0;
    }
    var pluralized_string = singular_string.pluralize();
    if(singular_string == "is") {
        pluralized_string = "are"
    }

    var str = pluralized_string
    if(count === 1) {
        str = singular_string;
    }
    if(without_count) {
        return str
    }
    return count + " " + str
}

function pad(n) {
    if(n <= -10) {
        return n
    }
    if(n < 0) {
        return "-0" + (-n)
    }
    if(n < 10) {
        return "0" + n
    }
    return n
}

// add file_extension function to string
if (typeof String.prototype.file_extension != 'function') {
    String.prototype.file_extension = function (){
        return this.split(".").last()
    };
}


// add contains function to string
if (typeof String.prototype.contains != 'function') {
    String.prototype.contains = function (str){
        return this.indexOf(str) > -1
    };
}

// add hyphenated function to string
if (typeof String.prototype.hyphenated != 'function') {
    String.prototype.hyphenated = function (){
        return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    };
}

// add to_title_case function to string
if (typeof String.prototype.to_title_case != 'function') {
    String.prototype.to_title_case = function (){
        return this.replace(/\w\S*/g, function(txt){return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();});
    };
}

// add starts_with function to string
if (typeof String.prototype.starts_with != 'function') {
    String.prototype.starts_with = function (str){
        if(is_empty(str)) return false
        return this.slice(0, str.length) == str;
    };
}

if (typeof String.prototype.any_word_starts_with != 'function') {
    String.prototype.any_word_starts_with = function (str){
        if(is_empty(str)) return false
        var arr = this.split(" ")
        for(var i = 0; i < arr.length; i++) {
            var substr = arr[i]
            if(substr.starts_with(str)) return true
        }
        return false
    };
}

// remove all characters that are not alphabets, numbers or underscores
function alphanumeric_underscore(str) {
    return str.replace(/\W/g, '')
}

// add function to get text between two strings
if (typeof String.prototype.text_between != 'function') {
    String.prototype.text_between = function (str1, str2){
        var start_index = 0;
        if(!is_empty(str1)) {
            start_index = this.indexOf(str1);
            if(start_index == -1) {
                start_index = 0;
            }
        }
        var end_index = this.length;
        if(!is_empty(str2)) {
            end_index = this.indexOf(str2)
            if(end_index == -1) {
                end_index = this.length
            }
        }
        return this.substring(start_index + 1, end_index);
    };
}

function text_if_empty(str, text) {
    if(is_empty(str)) {
        return text
    }
    return str
}

function dash_if_empty(str) {
    return text_if_empty(str, "-")
}

function zero_if_empty(str) {
    return text_if_empty(str, 0)
}
