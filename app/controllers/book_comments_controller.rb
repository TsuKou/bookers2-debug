class BookCommentsController < ApplicationController
  before_action :authenticate_user!
  def create
    @book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comment_params)
    comment.book_id =@book.id
    comment.save
    # redirect_back(fallback_location: root_path) 「jsファイル読み込ませのためコメントアウト/削除」

  end

  def destroy
     @book = Book.find(params[:book_id])
    BookComment.find(params[:id]).destroy
    # redirect_back(fallback_location: root_path)　「jsファイル読み込ませのためコメントアウト/削除」
  end

  private

  def book_comment_params
    params.require(:book_comment).permit(:comment)

  end

end
