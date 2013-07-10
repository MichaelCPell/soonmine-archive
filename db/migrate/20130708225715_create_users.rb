class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :image_url, default: "/assets/missing_profile_image.png"

      t.timestamps
    end
  end
end
