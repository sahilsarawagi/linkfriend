class Notification < ApplicationRecord
  belongs_to :recipient, class_name: "User"
  belongs_to :actor, class_name: "User"
  belongs_to :notifiable, polymorphic: true

  scope :leatest, ->{order("created_at DESC")}
  scope :unviewed, ->{where(viewed: false)}
end
