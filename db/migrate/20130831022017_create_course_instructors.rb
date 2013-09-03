class CreateCourseInstructors < ActiveRecord::Migration
  def change
    create_table :course_instructors do |t|
      t.integer :course_id
      t.integer :instructor_id
      t.boolean :primary

      t.timestamps
    end
  end
end
