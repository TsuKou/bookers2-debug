class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy #応用課題3で追加
  has_many :book_comments, dependent: :destroy
  validates :title, presence: true
  validates :body, presence: true, length:{maximum:200}

  def favorited_by?(user) #「favorited_by?メソッド」を使用　#応用課題3で追加
    favorites.exists?(user_id: user.id)
  end
#--ここから--応用課題5-検索方法分岐--
  def self.looks(search, word)
    if search == "perfect_match"
      @book = Book.where("title LIKE?","#{word}")
    elsif search == "forward_match"
      @book = Book.where("title LIKE?","#{word}%")
    elsif search == "backward_match"
      @book = Book.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @book = Book.where("title LIKE?","%#{word}%")
    else
      @book = Book.all
    end
  end
#--ここまで--応用課題5---
end
