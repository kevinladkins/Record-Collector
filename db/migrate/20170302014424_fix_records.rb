class FixRecords < ActiveRecord::Migration[5.0]
  def change
    drop_table :records
  end
end
