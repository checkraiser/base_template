function get_ancestry_ids(category) {
    if(is_empty(category) || is_empty(category.ancestry)) {
        return []
    }
    return category.ancestry.split("/")
}

function get_ancestor_path(category, categories) {
    if(categories === undefined) {
        categories = app_data.categories
    }
    var ancestry_ids = get_ancestry_ids(category)
    var ancestor_path = []
    for(var i = 0; i < ancestry_ids.length; i++) {
        var ancestor_id = ancestry_ids[i]
        var ancestor = categories[ancestor_id]
        ancestor_path.push(ancestor)
    }
    return ancestor_path
}

function category_path(category_id, max_path_length, categories) {
    if(is_empty(category_id)) {
        return []
    }
    if(categories === undefined) {
        categories = app_data.categories
    }
    var category = categories[category_id]
    var category_path = get_ancestor_path(category, categories)
    category_path.push(category)
    if(max_path_length && max_path_length < category_path.length){
        category_path = category_path.slice(category_path.length - max_path_length)
    }
    return category_path
}

function category_visible_in_tree(category_id) {
    return !is_empty(app_data.categories[category_id])
}
