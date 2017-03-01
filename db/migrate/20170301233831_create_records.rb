class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.string :name
      t.integer :artist_id
      t.integer :label_id
      t.string :format
      t.string :type
      t.integer :rpm
      t.integer :upc
      t.integer :realease_year
    end
  end
end
