module CoursesHelper
  def status_label_class(status)
    emphases = {"Complete" => "label-success",
      "In Progress" => "label-warning",
      "Overdue" => "label-important",
      "Future" => "label-info"}
    emphases[status]
  end

  def status_text_class(status)
    emphases = {"Complete" => "text-success",
      "In Progress" => "text-warning",
      "Overdue" => "text-error",
      "Future" => "text-info"}
    emphases[status]
  end

  def status_bar_class(status)
    emphases = {"Complete" => "bar-success",
      "In Progress" => "bar-warning",
      "Overdue" => "bar-danger",
      "Future" => ""}
    emphases[status]
  end
end
