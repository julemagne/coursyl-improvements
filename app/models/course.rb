class Course < ActiveRecord::Base
  has_many :assignments, order: :due_at
  has_many :course_instructors
  has_many :instructors, through: :course_instructors
  has_many :lessons, order: :held_at
  has_many :policies, order: :order_number

  def instructor_name
    return instructors.map{|i| i.full_name}.join(', ')

    #TODO: figure out how to do a where like this, but with a field from the through
    #return instructors.where(primary: true).map{&:full_name}.join(', ')
  end
end
