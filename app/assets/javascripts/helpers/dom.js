function has_parent_with_class(object, class_selector) {
    return object.closest("." + class_selector).hasClass(class_selector)
}