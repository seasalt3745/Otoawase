class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  attachment :image, destroy: false
  include JpPrefecture
  jp_prefecture :area
  # has_one_attached :image#ファイルアップロード用?

  enum status: { 楽しく遊びたい!: 0, 実力を試してみたい!: 1, 演奏会ができるレベルまでやりたい!: 2, 本気で頑張りたい!: 3 }

  has_many :user_instruments
  has_many :instruments, through: :user_instruments
  has_many :user_genres
  has_many :genres, through: :user_genres
  has_many :messages, dependent: :destroy
  has_many :entries, dependent: :destroy

# 能動的関係=フォローしている人の情報
  has_many :relationships, dependent: :destroy # フォローしてる人取得？
  has_many :followings, through: :relationships, source: :follow # sourceはモデルから　# 自分がフォローしている人
# 受動的関係＝フォロワー、フォローしてくる人の情報
  has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follower_id', dependent: :destroy # フォロワー取得
  has_many :followers, through: :reverse_of_relationships, source: :user # 自分をフォローしている人

# throughオプションによりrelationships経由でfollowings・followersにアクセスできるようになる＝relationshipは中間テーブルであるという意味付け
# = 架空のモデルを介して、対象のモデルと多対多の関連付け => これにより情報抽出可能
# sourceオプション = has_many :through関連付けの関連付け元（従属するモデル※今回はモデルではないもの〔follow〕も含む）名を指定する
# foreign_keyオプション = 関連付けるモデルを指す外部キー(FK)のカラム名を設定する。このオプションを使用しなければ、「belongs_toの引数_id」が指定される
# = follower_idを入り口としてねっていう意味。sourceは出口。
# following_id = 人、follower_id = アンカー　人とアンカーは紐で繋がってる（relationshipテーブル）


#フォローする
  def follow(other_user)#other_userには、例えばfollowing = current_user.follow(user)の()内が自動で代入される
    unless self == other_user
      self.relationships.find_or_create_by(follower_id: other_user.id)
    end
  end

#フォローを外す
  def unfollow(other_user)
    relationship = self.relationships.find_by(follower_id: other_user.id)
    relationship.destroy if relationship #existなら
  end

#フォローしてるか確認する(してればtrueを返す)
  def following?(other_user)
    self.followings.include?(other_user)
  end


  validates :name, presence: true, uniqueness: true
  before_save { self.email = email.downcase }
  validates :email, presence: true, uniqueness: true
  validates :experience, numericality: { only_integer: true }, allow_blank: true
  validates :record, length: {maximum: 100}
  validates :introduction, length: {maximum: 200}

end
