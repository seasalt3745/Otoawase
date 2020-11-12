class Message < ApplicationRecord

  belongs_to :user
  belongs_to :room

  validates :message, presence: true, length: {maximum: 200}

end
