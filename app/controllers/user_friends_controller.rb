class UserFriendsController < ApplicationController
  def create
    Friend.create(user_id: params[:user_id], friend_id: params[:format])
    redirect_to users_path, notice: 'Friend Request Sent!'
  end
end
