class RelationshipsController < ApplicationController

  def follow
    current_user.follow(params[:id])
    redirect_back(fallback_location: users_path)
  end

  def unfollow
    current_user.unfollow(params[:id])
    redirect_back(fallback_location: users_path)
  end
  
  # フォローしている人一覧
  def follower
    user = User.find(params[:user_id])
    @users = user.followings
  end

  # フォローされている人一覧
  def followed
    user = User.find(params[:user_id])
    @users = user.followers
  end
  
end
