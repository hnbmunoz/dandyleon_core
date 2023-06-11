class CreateTransaction < ActiveRecord::Migration[7.0]
  def change
    create_table :transactions do |t|
      t.text :products, default: ""
      t.integer :user_id
      t.string :status, default: "pending"
      t.float :net_price, default: 0.0
      t.timestamps
    end
  end
end
