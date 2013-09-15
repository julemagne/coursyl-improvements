module CoursesHelper
  def status_label_class(status)
    emphases = {"Complete" => "label-success",
      "Future" => "label-info",
      "In Progress" => "label-warning"}
    emphases[status]
  end
end
