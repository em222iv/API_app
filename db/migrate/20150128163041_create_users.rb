class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :key, unique:true
      t.timestamps true
    end
  end
end
