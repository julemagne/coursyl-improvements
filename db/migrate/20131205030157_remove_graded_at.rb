class RemoveGradedAt < ActiveRecord::Migration
  def change
    remove_column :assignment_grades, :graded_at, :datetime
  end
end
