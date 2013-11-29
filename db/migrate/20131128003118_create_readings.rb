class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      t.integer :lesson_id
      t.string :caption
      t.string :url
      t.integer :order_number

      t.timestamps
    end
  end
end
