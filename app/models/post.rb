class Post < ApplicationRecord
  belongs_to :user
  has_one_attached :photo, dependent: :destroy
  has_many :comments, dependent: :destroy     
end
