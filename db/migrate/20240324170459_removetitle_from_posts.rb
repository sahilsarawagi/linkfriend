class RemovetitleFromPosts < ActiveRecord::Migration[7.1]
  def self.up
    remove_column  :posts, :title
  end
end
