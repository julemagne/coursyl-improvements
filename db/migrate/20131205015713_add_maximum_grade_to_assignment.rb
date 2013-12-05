class AddMaximumGradeToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :maximum_grade, :float
  end
end
