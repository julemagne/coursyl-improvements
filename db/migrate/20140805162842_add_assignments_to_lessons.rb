class AddAssignmentsToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :pre_class_assignment_id, :integer
    add_column :lessons, :in_class_assignment_id, :integer
  end
end
