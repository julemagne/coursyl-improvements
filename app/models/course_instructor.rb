class CourseInstructor < ActiveRecord::Base
  belongs_to :course
  belongs_to :instructor, class_name: "User"

  validates :primary, uniqueness: {scope: :course, allow_blank: true}
end
