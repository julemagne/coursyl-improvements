class AddGradingModeToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :grading_method, :string, default: "Assignment"
  end
end
