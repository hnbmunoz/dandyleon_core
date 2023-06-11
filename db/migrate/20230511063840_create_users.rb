class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email, default: ""
      t.string :fname, default: ""
      t.string :mname, default: ""
      t.string :lname, default: ""
      t.string :display_name, default: ""
      t.string :reset_token, default: ""
      t.string :activation_token, default: ""
      t.string :authorization_token, default: ""
      t.string :status, default: ""
      t.timestamps
    end
  end
end
