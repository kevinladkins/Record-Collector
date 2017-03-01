class CreateRecordUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :record_users do |t|
      t.integer :user_id
      t.integer :record_id
    end
  end
end
