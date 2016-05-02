function get_sprint_date_options(sprint_duration, number_of_sprints) {
    if(!number_of_sprints) {
        number_of_sprints = 12
    }

    var today = new Date();
    var current_start_of_sprint = get_monday(today)

    var sprint_date_options = []
    for(var i = 0; i < number_of_sprints; i++) {
        var current_end_of_sprint = add_days(current_start_of_sprint, sprint_duration * 7 - 1)
        var option = {start_date: current_start_of_sprint, end_date: current_end_of_sprint, test: "hello"}
        sprint_date_options.push(option)
        current_start_of_sprint = add_days(current_end_of_sprint, 1)
    }
    return sprint_date_options
}