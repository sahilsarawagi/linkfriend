class AddUserIdToPosts < ActiveRecord::Migration[7.1]
  def change
    add_reference :posts, :user, foreign_key: {to_table: :users}
  end
end
