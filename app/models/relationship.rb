class Relationship < ApplicationRecord

  belongs_to :following, class_name: 'User', foreign_key: :following_id
  belongs_to :follower, class_name: 'User', foreign_key: :follower_id

  validates :following_id, presence: true
  validates :follower_id, presence: true

end
