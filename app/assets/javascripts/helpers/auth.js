var app_user = {}
var auth = {}

function is_owner(resource) {
    if(!app_user.is_signed_in) {
        return false
    }
    return app_user.id === resource.user_id
}

function is_organization_resource(resource) {
    if(is_empty(app_user.organization_id) || is_empty(resource) || is_empty(resource.organization_id)) {
        return false
    }
    return app_user.organization_id === resource.organization_id
}

auth.can_manage = function(resource_type) {
    if(app_user.permissions["can_manage_" + resource_type]) {
        return true
    }
    return false
}

auth.can_update_product = function(product) {
    if(app_user.acts_as_ct_r3) {
        return true
    }
    if(is_owner(product)) {
        return true
    }
    if(is_organization_resource(product) && (app_user.acts_as_supplier || app_user.acts_as_consultant_r2)) {
        return true
    }

    return false
}