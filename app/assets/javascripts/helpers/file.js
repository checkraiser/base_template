get_file_extension = function(url) {
  return url.split('.').pop();
}

get_file_icon_url = function(icon_name){
    return gon.assets.file_icons[icon_name]
}
