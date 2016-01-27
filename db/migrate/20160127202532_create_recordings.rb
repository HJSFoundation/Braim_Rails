class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.integer :user_id
      t.integer :song_id
      t.datetime :date
      t.integer :duration

      t.timestamps null: false
    end
  end
end
