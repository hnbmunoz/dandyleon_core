class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name, default: ""
      t.string :description, default: ""
      t.string :url, default: ""    
      t.timestamps
    end
  end
end
