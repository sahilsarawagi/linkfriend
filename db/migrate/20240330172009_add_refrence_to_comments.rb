class AddRefrenceToComments < ActiveRecord::Migration[7.1]
  def change
    add_reference :comments, :user, foreign_key: {to_table: :users}
    add_reference :comments, :post, foreign_key: {to_table: :posts}
  end
end
