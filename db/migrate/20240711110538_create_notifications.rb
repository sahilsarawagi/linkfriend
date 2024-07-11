class CreateNotifications < ActiveRecord::Migration[7.1]
  def change
    create_table :notifications do |t|
      t.references :recipient, null: false, foreign_key: { to_table: :users } # recipient refers to users table
      t.references :actor, null: false, foreign_key: { to_table: :users }     # actor refers to users table
      t.boolean :viewed, default: false
      t.string :action
      t.references :notifiable, polymorphic: true, null: false

      t.timestamps
    end
  end
end
