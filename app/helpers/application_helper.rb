module ApplicationHelper

  def display_title(text)
    text.titlecase
  end

  def display_check(text)
    if text == false
      " "
    else
      "&#10003;".html_safe
    end
  end

  def display_time(time)
    time.strftime("%m/%d/%y")
  end
end
