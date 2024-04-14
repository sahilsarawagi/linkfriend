class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User'
  belongs_to :followee, class_name: 'User'

  validates :follower_id, uniqueness: { scope: :followee_id }
  validates :followee_id, uniqueness: { scope: :follower_id }

  def self.pending_field(follower_id, followee_id)
    find_by("follower_id = ? AND followee_id=?", follower_id, followee_id)
  end

  def self.follower_list(followee_id, pending_status)
    where("followee_id=? AND pending= ? ",followee_id, pending_status)
  end

  def self.followee_list(follower_id, pending_status)
    where("follower_id = ? AND pending= ?", follower_id, pending_status)
  end
  # TODO: correct the follower and following counts (where pending: false)
end
