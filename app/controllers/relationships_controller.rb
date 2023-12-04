class RelationshipsController < ApplicationController
  before_action :authenticate_user!
  #--ここから----------------------------
  #　フォローするとき
  def create
    user = User.find(params[:user_id])
    current_user.follow(user)
    redirect_to request.referer #操作後元画面に遷移するパス？「request.referer」
  end
  #--ここまで----------------------------

  #--ここから---フォロー外すとき---
  def destroy
    user = User.find(params[:user_id])
    current_user.unfollow(user)
    redirect_to request.referer
  end
  #--ここまで---フォロー外すとき---

  #--ここから---フォロー一覧---
  def followings
    user = User.find(params[:user_id])
    @users = user.followings #「user.yes_follow」アソシエーション部分
  end
  #--ここまで---フォロー一覧---

  #--ここから---フォロワー一覧---
  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
  #--ここまで---フォロワー一覧---

end