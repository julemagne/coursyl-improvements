class CreateAwardedAchievements < ActiveRecord::Migration
  def change
    create_table :awarded_achievements do |t|
      t.integer :achievement_id
      t.integer :course_student_id
      t.boolean :awarded
      t.text :comments

      t.timestamps
    end
  end
end
