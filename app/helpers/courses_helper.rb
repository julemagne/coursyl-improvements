module CoursesHelper
  def badge(achievement, options)
    badge_color = options[:muted] ? '#DDDDDD' : achievement.badge_color
    icon_color  = options[:muted] ? '#FFFFFF' : achievement.icon_color
    html  = "<div class='award award-certificate' style='color: #{badge_color};'><i class='fa fa-certificate'></i></div>"
    html += "<div class='award award-overlay' style='color: #{icon_color};'><i class='fa #{achievement.icon}'></i></div>"
    html += "<div class='award award-gloss'></div>" unless options[:muted]

    html.html_safe
  end
end
