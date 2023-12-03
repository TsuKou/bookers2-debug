class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id])
    current_user.follow(params[:user_id])
    @user.create_notification_follow!(current_user)
    redirect_to request.referer
  end

  def destroy
    current_user.unfollow(params[:user_id])
    redirect_to request.referer
  end

  def yes_follow
    user = User.find(params{:user_id})
    @users = user.yes_follow
  end

  def no_follow
    user = User.find(params[:user_id])
    @users = user.no_follow
  end
end
