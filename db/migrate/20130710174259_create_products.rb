class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, default: "No Product Name"
      t.integer :price, default: 0
      t.string :image_url, default: "/assets/no_product_image.jpg" 
      t.string :state
      t.integer :quantity
      t.string :offsite_url
      t.integer :intensity
      t.integer :list_id

      t.timestamps
    end
  end
end
