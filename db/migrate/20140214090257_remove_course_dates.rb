class RemoveCourseDates < ActiveRecord::Migration
  def change
    remove_column :courses, :started_on, :date
    remove_column :courses, :ended_on, :date
  end
end
