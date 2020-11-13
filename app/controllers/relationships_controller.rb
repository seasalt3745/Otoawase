class RelationshipsController < ApplicationController

before_action :authenticate_user!

  def index
  	# (current_user.followed_by? @user) && (@user.followed_by? current_user)
  end

  def create
    user = User.find(params[:follow_id])
    following = current_user.follow(user)

      if following.save
        # flash[:success] = 'ユーザーをフォローしました'
        redirect_to request.referer
      else
        # flash.now[:alert] = 'ユーザーのフォローに失敗しました'
        redirect_to request.referer
      end

  end

  def destroy
    user = User.find(params[:follow_id])
      following = current_user.unfollow(user)

      if following.destroy
        # flash[:success] = 'ユーザーのフォローを解除しました'
        redirect_to request.referer
      else
        # flash.now[:alert] = 'ユーザーのフォロー解除に失敗しました'
        redirect_to request.referer
      end

  end


  def following
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def follower
    user = User.find(params[:user_id])
    @users = user.followers
  end

end
