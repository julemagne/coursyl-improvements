class AddInstructorAndApproved < ActiveRecord::Migration
  def change
    add_column :users, :wants_to_be_instructor, :boolean
    add_column :users, :instructor, :boolean
    add_column :course_students, :approved, :boolean

    CourseStudent.all.each do |cs|
      cs.approved = true
      cs.save!
    end

    User.where(admin: true).all.each do |u|
      u.instructor = true
      u.save!
    end
  end
end
