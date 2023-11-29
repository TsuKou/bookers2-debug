class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit,:update] #自分で追加　editを追加

  def show
    @user = User.find(params[:id])
    @book = Book.new
    @books = @user.books
  end

  def index
    @users = User.all
    @book = Book.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @books = @user.books
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
      #()内、current_user(変更前)→@user(変更後),「notice」の記述を教材で習ってない記述型へ修正
    else
      render "edit" #showからeditへ変更
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
