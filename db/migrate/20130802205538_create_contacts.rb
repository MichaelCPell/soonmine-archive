class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :firstname
      t.string :lastname
      t.string :relationship
      t.integer :user_id
      t.string :email

      t.timestamps
    end
  end
end
