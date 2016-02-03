class AddSignalQualityToEntries < ActiveRecord::Migration
  def change
    add_column :entries, :signal_quality, :integer
  end
end
