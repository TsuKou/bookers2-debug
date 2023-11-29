class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books
  has_one_attached :profile_image

  validates :name, length: { minimum: 2, maximum: 20 }, uniqueness: true
  validates :introduction, length:{maximum: 50 } #introductionのバリデーション文字制限を追加、指定が無く「Rspec」実施し指定があることを知り指定

  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
end
