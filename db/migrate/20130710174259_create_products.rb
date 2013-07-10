class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name, default: "Missing Product Name"
      t.integer :price, default: "Missing Product Price"
      t.string :image_url, default: "/assets/missing_product_image.jpg" 
      t.string :state
      t.integer :quantity
      t.string :offsite_url
      t.integer :list_id

      t.timestamps
    end
  end
end
