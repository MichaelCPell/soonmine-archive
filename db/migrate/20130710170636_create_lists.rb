class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title, default: "Primary"
      t.string :description
      t.integer :user_id
      t.string :privacy

      t.timestamps
    end
  end
end
