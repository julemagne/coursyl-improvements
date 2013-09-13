class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.integer :term_id
      t.string :name
      t.string :course_code
      t.string :period
      t.string :prerequisites
      t.text :description
      t.text :materials
      t.text :objectives

      t.timestamps
    end
  end
end
