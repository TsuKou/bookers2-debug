class RelationshipsController < ApplicationController
  #--ここから---フォロー作成------------
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer #操作後元画面に遷移するパス？「request.referer」
  end
  #--ここまで----------------------------

  #--ここから---フォロー削除------------
  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end
  #--ここまで----------------------------

  #---↓----フォロー/フォロワー一覧処理
  def yes_follow
    user = User.find(params{:user_id})
    @users = user.yes_follow　#「user.yes_follow」アソシエーション部分
  end

  def no_follow
    user = User.find(params[:user_id])
    @users = user.no_follow
  end
  #--------------ここまで--------------
end
