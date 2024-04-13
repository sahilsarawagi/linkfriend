class AddPendingToFollows < ActiveRecord::Migration[7.1]
  def change
    add_column :follows, :pending, :boolean, default: false
  end
end
