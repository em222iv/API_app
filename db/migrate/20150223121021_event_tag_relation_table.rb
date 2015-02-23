class EventTagRelationTable < ActiveRecord::Migration
  def change
    create_table :events_tags do |t|
      t.belongs_to :event
      t.belongs_to :tag
      t.timestamps null: false
    end
  end
end
