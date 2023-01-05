class UserFriendsController < ApplicationController
  before_action :set_friend_id, only: [:create]
  def create
    Friend.create(user_id: current_user.id, friend_id: set_friend_id.id)
    redirect_to users_path, notice: 'Friend Request Sent!'
  end

  private

  def set_friend_id
    @friend_id = User.friendly.find(params[:format])
  end
end
