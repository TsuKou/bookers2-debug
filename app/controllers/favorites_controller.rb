class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.new(book_id: @book.id)
    favorite.save
    #応用課題6でコメントアウト、 redirect_back(fallback_location: root_path) #「redirect_back(fallback_locaton: ***_path」は直前のページにリダイレクト
  end

  def destroy
    @book = Book.find(params[:book_id])
    favorite = current_user.favorites.find_by(book_id: @book.id)
    favorite.destroy
    #応用課題6でコメントアウト、 redirect_back(fallback_location: root_path)
  end

end
