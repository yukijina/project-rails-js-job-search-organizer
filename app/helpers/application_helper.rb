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

  def display_job_type(text)
    if text == false
      "Non-Full Time Position"
    else
      "Full Time"
    end
  end

  def display_time(time)
    time.strftime("%m/%d/%y")
  end

  def display_salary(salary)
    if salary == 0
      "n/a"
    else
      number_to_currency(salary, precision: 0) + " / year"
      #presidion(decimal)
    end
  end


end
