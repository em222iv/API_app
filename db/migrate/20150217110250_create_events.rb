class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :positionID
      t.integer :creatorID
      t.string :description
      t.timestamps null: false
    end
  end
end
