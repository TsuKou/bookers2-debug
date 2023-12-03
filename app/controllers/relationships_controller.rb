class RelationshipsController < ApplicationController
  #--ここから----------------------------
  #　フォローするとき
  def create
    current_user.follow(params[:user_id])
    redirect_to request.referer #操作後元画面に遷移するパス？「request.referer」
  end
  #--ここまで----------------------------

  #--ここから---------------------------
  #　フォロー外すとき
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  #--ここまで----------------------------

  #--ここから----------------------------
  #　フォロー一覧
  def followings
    user = User.find(params[:user_id])
    @users = user.followings #「user.yes_follow」アソシエーション部分
  end

  #　フォロワー一覧
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  #--ここまで-----------------------------
end