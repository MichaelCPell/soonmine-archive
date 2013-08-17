class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :name
      t.date :date
      t.integer :user_id
      t.string :recipient_email

      t.timestamps
    end
  end
end
