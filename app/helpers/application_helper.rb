module ApplicationHelper
  def icon_css(type)
    case type
    when 'text'
      return 'document'
    when 'audio'
      return 'bars'
    when 'video'
      return 'play'
    end
  end

  def get_video_embed_url(html)
    videos = []
    videos.concat(parse_videos(html, 'youtube_short'))
    videos.concat(parse_videos(html, 'youtube'))
    unless videos.blank?
      return "https://www.youtube.com/embed/%s?version=3&enablejsapi=1" % videos[0]['id']
    end
  end

  def get_videos(html)
    videos = []
    videos.concat(parse_videos(html, 'youtube_short'))
    videos.concat(parse_videos(html, 'youtube'))
    videos.concat(parse_videos(html, 'vimeo'))
  end

  def video_embeds(html, width=1280, height=720)
    videos = get_videos(html)

    videos.each do |v|
      case v['type']
      when 'youtube', 'youtube_short'
        embed = '<iframe src="https://www.youtube.com/embed/' + v['id'] + '?controls=0" width="' + width.to_s + '" height="' + height.to_s + '" frameborder="0" allowfullscreen></iframe>'
      when 'vimeo'
        embed = '<iframe src="https://player.vimeo.com/video/' + v['id'] + '" width="' + width.to_s + '" height="' + height.to_s + '" frameborder="0" webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>'
      end

      embed = '<div class="video-wrap">' + embed + '</div>' if embed

      html.sub!(v['url'], embed)
    end

    html
  end

  # remove URLs for listing views
  def strip_videos(html)
    videos = get_videos(html)
    videos.each do |v|
      html.sub!(v['url'], '')
    end
    html
  end

  def parse_videos(html, type)
    regex = nil
    videos = []

    case type
    when 'youtube_short'
      regex = /\s*(https?:\/\/youtu.be\/([a-zA-Z0-9\-_]+))/i
    when 'youtube'
      regex = /\s*(https?:\/\/www.youtube.com\/watch\?v=([a-zA-Z0-9\-_]+))/i
    when 'vimeo'
      regex = /\s*(https?:\/\/vimeo.com\/([a-zA-Z0-9\-_]+))/i
    end

    if regex
      matches = html.scan(regex)

      matches.each do |match|
        videos << { 'url' => match[0], 'id' => match[1], 'type' => type }
      end
    end

    videos
  end
end