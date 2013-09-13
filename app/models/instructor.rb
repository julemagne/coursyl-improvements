class Instructor < ActiveRecord::Base
  has_many :course_instructors
  has_many :courses, through: :course_instructors

  def full_name
    #TODO find a clever way to make the . only appear if there is a middle_name
    return "#{title} #{first_name} #{middle_name.first}. #{last_name}"
  end
end
