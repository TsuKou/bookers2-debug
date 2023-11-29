class BooksController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy] #解説確認前は記述必要化不明だったが、解説確認後に追加

  def show
    @book_new = Book.new #自分で追記
    @book = Book.find(params[:id])
    @book_user = User.find(@book.user.id)
  end

  def index
    @book = Book.new #追加
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.valid?
      @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    @book = Book.find(params[:id])
    if @book.user == current_user
      render "edit"
    else
      redirect_to books_path
    end
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy #deleteから変更
    @book = Book.find(params[:id])
    @book.destroy #「r」が抜けていたため追加
    redirect_to books_path, notice: "successfully delete book!" #解説を確認しながら「notice」を追加
  end

  private

  def book_params
    params.require(:book).permit(:title, :body) #( :body )をpermit内へ追加
  end

  def ensure_correct_user #解説確認前は記述必要化不明だったが、解説確認後に追加
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end

end
