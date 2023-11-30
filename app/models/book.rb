class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy #応用課題3で追加
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:200}

  def favorited_by?(user) #「favorited_by?メソッド」を使用　#応用課題3で追加
    favorites.exists?(user_id: user.id)
  end

end
