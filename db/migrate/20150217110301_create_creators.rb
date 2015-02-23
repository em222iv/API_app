class CreateCreators < ActiveRecord::Migration
  def change
    create_table :creators do |t|
      t.string :creator
      t.timestamps null: false
    end
  end
end
