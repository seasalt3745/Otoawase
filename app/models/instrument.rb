class Instrument < ApplicationRecord

  belongs_to :user, optional: true#外部キーがnilでも保存可
  has_many :user

  attachment :image, destroy: false

end
