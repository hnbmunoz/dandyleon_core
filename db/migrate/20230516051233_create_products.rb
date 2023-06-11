class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name, default: ""
      t.integer :category_id
      t.string :description, default: ""
      t.float :price, default: 0.0
      t.float :discount, default: 0.0
      t.string :url, default: ""
      t.timestamps
    end
  end
end
