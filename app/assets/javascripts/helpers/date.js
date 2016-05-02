Date.prototype.add_days = function(days) {
    this.setDate(this.getDate() + parseInt(days));
    return this;
};

function dates_are_equal(datetime_1, datetime_2, dates_are_strings) {
    if(dates_are_strings) {
        var datetime_obj_1 = new Date(datetime_1);
        var datetime_obj_2 = new Date(datetime_2);
        return date_objects_are_equal(datetime_obj_1, datetime_obj_2)
    }
    return date_objects_are_equal(datetime_1, datetime_2);
}

function date_objects_are_equal(datetime_obj_1, datetime_obj_2) {
    if(datetime_obj_1.getFullYear() !== datetime_obj_2.getFullYear()) {
        return false;
    }
    if(datetime_obj_1.getMonth() !== datetime_obj_2.getMonth()) {
        return false;
    }
    if(datetime_obj_1.getDate() !== datetime_obj_2.getDate()) {
        return false;
    }
    return true;
}

function time_since_in_seconds(date) {
    var current_date = new Date();
    var date_obj = new Date(date);
    var difference_in_ms = current_date - date_obj;
    return difference_in_ms / 1000;
}

function time_left_in_seconds(date) {
    if(is_empty(date)) {
        return 0;
    }

    var current_date = new Date();
    var date_obj = new Date(date);
    var difference_in_ms = date_obj - current_date;
    return difference_in_ms / 1000;
}

function time_left_text(date) {
    var time_left = time_left_in_seconds(date);
    if(time_left < 0) {
        return "";
    }

    var seconds_in_a_day = 60 * 60 * 24
    var seconds_in_a_month = seconds_in_a_day * 30
    var seconds_in_a_year = seconds_in_a_day * 365

    var remaining_time = time_left;

    var years_left = Math.floor(remaining_time / seconds_in_a_year)
    remaining_time =  time_left - years_left * seconds_in_a_year

    var months_left = Math.floor(remaining_time / seconds_in_a_month)
    remaining_time = remaining_time - months_left * seconds_in_a_month

    var days_left = Math.floor(remaining_time / seconds_in_a_day)

    var str = "";
    if(years_left > 0) {
        if(years_left == 1) {
            str += years_left + " year "
        } else {
            str += years_left + " years "
        }
    }
    if(months_left > 0) {
        if(months_left == 1) {
            str += months_left + " month "
        } else {
            str += months_left + " months "
        }
    }
    if(days_left > 0) {
        if(days_left == 1) {
            str += days_left + " day"
        } else {
            str += days_left + " days"
        }
    }
    return str;
}

function time_ago(date) {
    var seconds = time_since_in_seconds(date)
    var seconds_in_a_day = 60 * 60 * 24
    var days = parseInt(seconds / seconds_in_a_day)
    if(days < 1) {
        return "today"
    }
    if(days < 7) {
        return inflected_text(days, "day") + " ago"
    }
    var weeks = days / 7
    if(weeks < 4) {
        return inflected_text(parseInt(weeks), "week") + " ago"
    }
    var months = days / 30
    return inflected_text(parseInt(months), "month") + " ago"
}

// shows today, yesterday for corresponding dates, else shows date as e.g. 15 Jun 2015
function display_date(date, show_context_dates) {
    var date_obj = new Date(date);

    if(show_context_dates !== false) {
        var today = new Date();
        if(date_objects_are_equal(today, date_obj)) {
            return "Today";
        }
        var yesterday = new Date();
        yesterday.setDate(today.getDate() - 1);
        if(date_objects_are_equal(yesterday, date_obj)) {
            return "Yesterday";
        }
    }
    var months = ["Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"];
    return date_obj.getDate() + " " + months[date_obj.getMonth()] + " " + date_obj.getFullYear();
}

function display_time(date) {
    return moment(date).format('h:mm A')
}

// shows today, yesterday for corresponding dates, else shows date as e.g. 15 Jun 2015
function display_datetime(date, show_context_dates) {
    if(is_empty(date))
        return "-"
    return display_date(date, show_context_dates) + ", " +  display_time(date)
}

function getTimezoneOffsetInHours(date) {
    var offset = -date.getTimezoneOffset()
    var hours = offset / 60
    var minutes = offset - hours * 60
    var str = pad(hours) + ":" + pad(minutes)
    if(offset > 0) {
        str = "+" + str
    }
    return str
}

function sql_datetime(date) {
    date = new Date(date)
    var datetime_str = date.getFullYear() + "-" + pad(date.getMonth() + 1) + "-" + pad(date.getDate())
    datetime_str += "T" + pad(date.getHours()) + ":" + pad(date.getMinutes()) + ":" + pad(date.getSeconds())
    datetime_str += "." + date.getMilliseconds() + getTimezoneOffsetInHours(date)
    return datetime_str
}

function current_sql_datetime() {
    var now = new Date()
    return sql_datetime(now)
}

function get_monday(date) {
    date = new Date(date)
    var day = date.getDay();
    var diff = date.getDate() - day + (day == 0 ? -6:1); // adjust when day is sunday

    return new Date(date.setDate(diff));
}

function add_days(date, days) {
    var result = new Date(date);
    result.setDate(result.getDate() + days);
    return result;
}

function display_duration(number_of_min) {
    if(!number_of_min) {
        number_of_min = 0
    }
    var hours = Math.floor(number_of_min / 60)
    var min = Math.floor(number_of_min - hours * 60)
    return hours + "h:" + pad(min) + "m"
}

function get_first_day_of_month(date) {
    date = new Date(date)
    var first_day = new Date(date.getFullYear(), date.getMonth(), 1);
    return first_day
}

function get_last_day_of_month(date) {
    date = new Date(date)
    var first_day = new Date(date.getFullYear(), date.getMonth() + 1, 0);
    return first_day
}

function today() {
    return new Date();
}

function yesterday() {
    var today = new Date();
    var yesterday = new Date();
    yesterday.setDate(today.getDate() - 1);
    return yesterday
}

function tomorrow() {
    var today = new Date();
    var tomorrow = new Date();
    tomorrow.setDate(today.getDate() + 1);
    return tomorrow
}