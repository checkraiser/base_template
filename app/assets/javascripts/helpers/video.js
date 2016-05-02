function get_youtube_video_id(url) {
    if(is_empty(url)) {
        return ""
    }
    var video_id = url.match(/(?:https?:\/{2})?(?:w{3}\.)?youtu(?:be)?\.(?:com|be)(?:\/watch\?v=|\/)([^\s&]+)/);
    if(is_empty(video_id)) {
        return ""
    }
    return video_id[1]
}

function youtube_thumbnail_url(url) {
    var video_id = get_youtube_video_id(url)
    return "https://img.youtube.com/vi/" + video_id + "/default.jpg"
}

function youtube_embed_url(url) {
    var video_id = get_youtube_video_id(url)
    return "https://www.youtube.com/embed/" + video_id
}