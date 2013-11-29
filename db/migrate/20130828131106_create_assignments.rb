class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.string :name
      t.integer :course_id
      t.datetime :active_at
      t.datetime :due_at
      t.boolean :grades_released
      t.boolean :students_can_submit
      t.float :fraction_of_grade

      t.timestamps
    end
  end
end
