class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.string :image_url 
      t.string :state
      t.integer :quantity
      t.integer :list_id

      t.timestamps
    end
  end
end
