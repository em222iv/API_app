class Adddigest < ActiveRecord::Migration
  def change
    rename_column :creators, :password, :password_digest
  end
end
