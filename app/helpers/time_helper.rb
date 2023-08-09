module TimeHelper
  def format_time_ago(time)
    time_ago = time_ago_in_words(time)
    if time_ago.include?('minute')
      "#{time_ago.gsub('minute', 'min')}"
    elsif time_ago.include?('hour')
      "#{time_ago.gsub('hour', 'h')}"
    else
      "#{time_ago} ago"
    end
  end
end
