class CreateAchievements < ActiveRecord::Migration
  def change
    create_table :achievements do |t|
      t.integer :course_id
      t.string :name
      t.string :category
      t.text :description
      t.string :icon
      t.string :icon_color
      t.string :badge_color
      t.integer :points

      t.timestamps
    end
  end
end
