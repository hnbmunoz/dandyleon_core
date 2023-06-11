class CreateAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :accounts do |t|
      t.integer :user_id
      t.string :username
      t.string :password      
      t.integer :user_level
      t.timestamps
    end
  end
end
