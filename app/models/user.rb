class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # Association for post       
  has_many :posts, dependent: :destroy
  
  # Association for comment
  has_many :comments, dependent: :destroy   

  # Association for follow
  has_many :followed_users, foreign_key: :follower_id, class_name: 'Follow'
  has_many :followees, through: :followed_users
  has_many :following_users, foreign_key: :followee_id, class_name: 'Follow'
  has_many :followers, through: :following_users

  has_one_attached :profile_photo, dependent: :destroy
  after_commit :add_default_profile, on: %i[create update]

  has_many :likes, dependent: :destroy

  private 
  def add_default_profile
    unless profile_photo.attached?
      profile_photo.attach(
        io: File.open(
          Rails.root / 'app' / 'assets' / 'images' / 'default_profile.jpg'
        ), filename: 'default_profile.jpg',
        content_type: 'image/* '
      )
    end
  end

end
