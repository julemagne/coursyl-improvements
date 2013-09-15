class Assignment < ActiveRecord::Base
  belongs_to :course

  def status
    if active_at > Time.now
      "Future"
    elsif due_at > Time.now
      "In Progress"
    else
      "Completed"
    end
  end

  def status_for_student(student)
  end
end
