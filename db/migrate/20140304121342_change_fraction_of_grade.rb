class ChangeFractionOfGrade < ActiveRecord::Migration
  def self.up
    change_column :assignments, :fraction_of_grade, :decimal, precision: 5, scale: 2
    rename_column :assignments, :fraction_of_grade, :percent_of_grade
    Assignment.all.each do |a|
      a.active_at = a.due_at - 1.minute if a.active_at >= a.due_at
      a.percent_of_grade = [a.percent_of_grade * 100, 100].min
      a.save!
    end
  end
  def self.down
    Assignment.all.each do |a|
      a.percent_of_grade = a.percent_of_grade / 100
      a.save!
    end
    rename_column :assignments, :percent_of_grade, :fraction_of_grade
    change_column :assignments, :fraction_of_grade, :float
  end
end
