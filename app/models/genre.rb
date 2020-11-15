class Genre < ApplicationRecord

  belongs_to :user, optional: true
  has_many :user

  attachment :image, destroy: false

end
