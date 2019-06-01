module ApplicationHelper

  def display_title(text)
    text.titlecase
  end

  def display_check(text)
    if text == false
      "No"
    else
      "Yes"
    end
  end

end
