class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :term_id
      t.string :name
      t.text :description
      t.string :course_code

      t.timestamps
    end
  end
end
