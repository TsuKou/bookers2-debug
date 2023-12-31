class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_many :favorites, dependent: :destroy #応用課題3で追加
  has_many :book_comments, dependent: :destroy #応用課題3で追加

  #--ここから--応用課題4---
  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy #応用課題4で追加
  has_many :reverse_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy #応用課題4で追加

  has_many :followings, through: :relationships, source: :followed
  has_many :followers, through: :reverse_relationships, source: :follower
  #--ここまで--応用課題4---

  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length:{maximum: 50 } #introductionのバリデーション文字制限を追加、指定が無く「Rspec」実施し指定があることを知り指定

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end

  #--ここから--応用課題4---
  def follow(user) #自作メソッド
    relationships.create(followed_id: user.id)
  end

  def unfollow(user) #自作メソッド
    relationships.find_by(followed_id: user.id).destroy
  end

  def following?(user)
    followings.include?(user)
  end
  #--ここまで--応用課題4---
  #--ここから--応用課題5-検索方法分岐--
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
    elsif search == "forward_match"
      @user = User.where("name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @user = User.where("name LIKE?", "%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?", "%#{word}%")
    else
      @user = User.all
    end
  end
  #--ここまで--応用課題5---

end