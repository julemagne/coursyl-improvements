module ApplicationHelper
  def markdown(content)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
    @markdown.render(content).html_safe
  end

  def percentage(number)
    number_to_percentage(number*100, precision: 0)
  end

  def weekday_abbreviation(date)
    day_hash = {"Thursday" => "Th", "Saturday" => "Sa", "Sunday" => "Su"}
    weekday = date.strftime("%A")
    day_hash[weekday] || weekday.first
  end
end
