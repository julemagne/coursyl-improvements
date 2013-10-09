class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name
      t.string :course_code
      t.string :period
      t.text :description
      t.date :started_on
      t.date :ended_on

      t.timestamps
    end
  end
end
