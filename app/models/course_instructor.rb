class CourseInstructor < ActiveRecord::Base
  belongs_to :course
  belongs_to :instructor

  validates :primary, uniqueness: {scope: :course, allow_blank: true}
end
