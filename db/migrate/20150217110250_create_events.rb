class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :position_id
      t.integer :creator_id
      t.string :description
      t.timestamps null: false
    end
  end
end
