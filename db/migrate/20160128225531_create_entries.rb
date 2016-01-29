class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.string :event_id 
      t.integer :user_id 
      t.integer :song_id 
      t.integer :recording_id 
      t.float :interest
      t.float :engagement
      t.float :focus
      t.float :relaxation
      t.float :instantaneousExcitement
      t.float :longTermExcitement
      t.float :stress
      t.integer :timestamp
      t.datetime :date        
      t.timestamps null: false
    end
  end
end
