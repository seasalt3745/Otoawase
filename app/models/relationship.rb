class Relationship < ApplicationRecord

  belongs_to :user
  belongs_to :follow, class_name: 'User'

  validates :following_id, presence: true
  validates :follower_id, presence: true

end
