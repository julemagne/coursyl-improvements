class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :term_id
      t.string :name
      t.string :course_code
      t.string :period
      t.text :description

      t.timestamps
    end
  end
end
