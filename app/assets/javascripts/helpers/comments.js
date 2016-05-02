function is_read(readable_item) {
    return !is_empty(readable_item.read_mark_id);
}

// assumes arr is sorted by created_at date, with earliest date as first item
function group_by_created_date(arr) {
    if(is_empty(arr)) {
        return [];
    }
    var grouped_arr = [];
    var first_item = arr[0];

    var previous_message_read = is_read(first_item);
    var first_unread_item_found = false;

    if(!is_read(first_item)) {
        first_unread_item_found = true;
        first_item.is_first_unread_item = true;
    }

    var current_date = new Date(first_item.created_at);
    var current_group = {date: current_date, array: [first_item]}

    for(var i = 1; i < arr.length; i++) {
        var current_item = arr[i];
        var current_item_date = new Date(current_item.created_at)

        if(!first_unread_item_found) {
            if(previous_message_read && !is_read(current_item)) {
                current_item.is_first_unread_item = true;
                first_unread_item_found = true;
            }
        }
        previous_message_read = is_read(current_item);

        // current item's date matches current_date
        // just push item to current group's array
        if(dates_are_equal(current_item_date, current_date, false)) {
            current_group.array.push(current_item);
            continue;
        }
        // current item's date does not match current_date
        // push current group into array
        grouped_arr.push(current_group)
        // create new group
        current_date = new Date(current_item.created_at);
        current_group = {date: current_date, array: [current_item]}
    }
    // case 1: array has 1 item, loop is skipped, so current_group needs to be pushed
    // case 2: array has more than 1 item, last item has equal date to previous item,
    // group was not pushed, so current_group needs to be pushed
    // case 3: array has more than 1 item, last item has different date then previous item,
    // new current group was created but not pushed, so current_group needs to be pushed
    grouped_arr.push(current_group)

    return grouped_arr;
}