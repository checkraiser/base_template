function is_empty(item) {
    return (item == undefined || item == null || item.length == 0);
}

function is_empty_hash(obj) {
    for(var prop in obj) {
        if(obj.hasOwnProperty(prop))
            return false;
    }
    return true;
}

function copy_array(source, target) {
    target.clear()
    for(var i = 0; i < source.length; i++) {
        target.push(source[i])
    }
}

// sort on key values
function key_sort(key) {
    return function(a, b) {
        if(a[key] < b[key]) return -1;
        if(a[key] > b[key]) return 1;
        return 0;
    }
}

// sort on multi keys
function keys_sort(properties) {
    /*
     * save the arguments object as it will be overwritten
     * note that arguments object is an array-like object
     * consisting of the names of the properties to sort by
     */
    var props = properties;
    return function (obj1, obj2) {
        var i = 0, result = 0, numberOfProperties = props.length;
        /* try getting a different result from 0 (equal)
         * as long as we have extra properties to compare
         */
        while(result === 0 && i < numberOfProperties) {
            result = key_sort(props[i])(obj1, obj2);
            i++;
        }
        return result;
    }
}

// returns a deep copy of obj
function deep_copy(obj) {
    if(is_empty(obj)) {
        return null
    }
    return JSON.parse(JSON.stringify(obj));
}

function copy_attributes(source, target) {
    for(var key in source) {
        target[key] = source[key]
    }
}

function keys_are_equal(source, target) {
    for(var key in source) {
        if(target[key] !== source[key]) {
            return false;
        }
    }
    for(var key in target) {
        if(target[key] !== source[key]) {
            return false;
        }
    }
    return true;
}

// returns an array of incremental numbers
// this is used for generating arrays of certain sizes
// e.g. if you need an array of size 9, pass in number_array(9)
// the return array will be [0, 1, 2, 3, 4, 5, 6, 7, 8]
function number_array(size) {
    var arr = [];
    for(var i = 0; i < size; i++) {
        arr.push(i);
    }
    return arr;
}

// add last() function to arrays
if (!Array.prototype.last){
    Array.prototype.last = function(){
        return this[this.length - 1];
    };
};

if (!Array.prototype.remove){
    Array.prototype.remove = function(item){
        this.splice(this.indexOf(item), 1)
    };
};


if (!Array.prototype.clear){
    Array.prototype.clear = function() {
        this.splice(0, this.length)
    };
};


if (!Array.prototype.find_by_key){
    Array.prototype.find_by_key = function(key, value){
        for(var i = 0; i < this.length; i++) {
            if(this[i][key] == value) {
                return this[i];
            }
        }
        return undefined;
    };
};


if (!Array.prototype.find_index_by_key){
    Array.prototype.find_index_by_key = function(key, value){
        for(var i = 0; i < this.length; i++) {
            if(this[i][key] == value) {
                return i;
            }
        }
        return undefined;
    };
};



if (!Array.prototype.find_by_index){
    Array.prototype.find_by_index = function(index, value){
        if(is_empty(value)) {
            return undefined;
        }
        for(var i = 0; i < this.length; i++) {
            if(this[i][index] == value) {
                return this[i];
            }
        }
        return undefined;
    };
};


if (!Array.prototype.find_by_id){
    Array.prototype.find_by_id = function(item_id){
        if(is_empty(item_id)) {
            return undefined
        }
        for(var i = 0; i < this.length; i++) {
            if(parseInt(this[i].id) === parseInt(item_id)) {
                return this[i];
            }
        }
        return undefined;
    };
};


if (!Array.prototype.find_index_by_id){
    Array.prototype.find_index_by_id = function(item_id){
        for(var i = 0; i < this.length; i++) {
            if(parseInt(this[i].id) === parseInt(item_id)) {
                return i;
            }
        }
        return undefined;
    };
};

if (!Array.prototype.remove_by_id){
    Array.prototype.remove_by_id = function(item_id){
        for(var i = 0; i < this.length; i++) {
            if(parseInt(this[i].id) === parseInt(item_id)) {
                this.splice(i, 1)
                break;
            }
        }
    };
};

if (!Array.prototype.remove_by_name){
    Array.prototype.remove_by_name = function(item_name){
        for(var i = 0; i < this.length; i++) {
            if(this[i].name === item_name) {
                this.splice(i, 1)
                break;
            }
        }
    };
};

/* NOTE: by default, the item will not be entirely replaced
 * instead, attributes on the new item will be copied over to the existing item
 * for example:
 * array[2] = {id: 15, name: "example", is_expanded: false}
 * new item = {id: 15, name: "updated example"}
 * after update_by_id: array[2] = {id: 15, name: "updated example", is_expanded: false}
 * this preserves the value of newly defined parameters such as is_expanded
 */
if (!Array.prototype.update_by_id){
    Array.prototype.update_by_id = function(item, replace_entirely){
        var item_updated = false
        for(var i = 0; i < this.length; i++) {
            if(parseInt(this[i].id) === parseInt(item.id)) {
                if (replace_entirely)
                    this[i] = item
                else
                    copy_attributes(item, this[i])
                item_updated = true
                break;
            }
        }
        return item_updated
    };
};

if (!Array.prototype.update_by_ids) {
    Array.prototype.update_by_ids = function(items) {
        for(var i = 0; i < items.length; i++) {
            this.update_by_id(items[i])
        }
    };
};

if (!Array.prototype.remove_by_ids){
    Array.prototype.remove_by_ids = function(items){
        for(var i = 0; i < items.length; i++){
            this.remove_by_id(items[i].id)
        }
    };
};
// returns a blank hash, with a placeholder value
// this is so rails will not throw a "param is missing or the value is empty" error
// if the user submits without filling in any values
function blank_hash() {
    return {
        blank_placholder_value: "-"
    };
}

function hashes_are_equal(hash_1, hash_2, comparison_keys) {
    for(var i = 0; i < comparison_keys.length; i++) {
        var key = comparison_keys[i]
        if(hash_1[key] != hash_2[key]) {
            return false
        }
    }
    return true;
}


function group_array(array, comparison_keys, init_grouped_item_data) {
    if(array == undefined || array == null || array.length == 0){
        return []
    }
    var previous_item = array[0]
    var grouped_item = {array: [previous_item]}
    var grouped_array = []
    for(var i = 1; i < array.length; i++) {
        var current_item = array[i]
        if(!hashes_are_equal(previous_item, current_item, comparison_keys)) {
            grouped_item.sample_item = grouped_item.array[0]
            if(init_grouped_item_data) {
                init_grouped_item_data(grouped_item)
            }
            grouped_array.push(grouped_item)
            grouped_item = {array: []}
        }
        grouped_item.array.push(current_item)
        previous_item = current_item
    }
    if(grouped_item.array.length > 0) {
        grouped_array.push(grouped_item)
        grouped_item.sample_item = grouped_item.array[0]
        if(init_grouped_item_data) {
            init_grouped_item_data(grouped_item)
        }
    }
    return grouped_array
}