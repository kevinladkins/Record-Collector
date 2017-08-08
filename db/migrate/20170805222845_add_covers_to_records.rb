class AddCoversToRecords < ActiveRecord::Migration[5.0]
  def change
    add_column :records, :cover, :string
  end
end
