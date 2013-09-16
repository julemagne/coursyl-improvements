class Assignment < ActiveRecord::Base
  belongs_to :course

  def status(user = nil)
    if active_at > Time.now
      "Future"
    elsif due_at > Time.now
      "In Progress"
    else
      "Complete"
    end
  end

end
