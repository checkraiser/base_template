function get_alpha_tree(array, nesting_level, key) {
    var alpha_tree = {}
    if(is_empty(array)) {
        return alpha_tree
    }
    for(var i = 0; i < array.length; i++) {
        if (!array[i])
            continue;
        // initialize curr_node as the alpha_tree
        var curr_node = alpha_tree
        var obj = array[i]
        var str = obj
        if(key) {
            str = obj[key]
        }
        str = str.toLowerCase()

        // assign curr_node to the appropriate node
        for(var j = 0; j < nesting_level-2; j++) {
            var letter = str[j]
            // create the node if needed
            if(is_empty(curr_node[letter])) {
                curr_node[letter] = {}
            }
            curr_node = curr_node[letter]
        }

        var final_letter_key = str[nesting_level-1]
        if(is_empty(curr_node[final_letter_key])) {
            curr_node[final_letter_key] = []
        }
        curr_node[final_letter_key].push(obj)
    }
    return alpha_tree
}

function get_tree_matches(tree, query, nesting_level, max_matches, exclude_exact_match, key) {
    if(is_empty(query) || query.length < nesting_level) {
        return [];
    }
    query = query.toLowerCase()
    var subtree = tree;
    for(var i = 0; i < nesting_level; i++) {
        subtree = subtree[query[i]]
        if(is_empty(subtree)) {
            return [];
        }
    }
    var matches = [];
    for(var i = 0; i < subtree.length; i++) {
        var item = subtree[i]
        var str = item
        if(key) {
            str = item[key]
        }
        str = str.toLowerCase()
        if(exclude_exact_match && item === query) {
            continue;
        }
        if(str.starts_with(query)) {
            matches.push(item);
        }
        if(!is_empty(max_matches) && matches.length === max_matches) {
            break;
        }
    }
    return matches;
}