class CreateTableProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.date :birthday
      t.integer :gender
      t.timestamps null: false
    end
  end
end
