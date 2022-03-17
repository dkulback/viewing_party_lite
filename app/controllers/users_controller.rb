class UsersController < ApplicationController
  before_action :current_user, only: %i[show discover]
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash.now[:user_errors] = 'User Not Registered'
      render 'new'
    end
  end

  def show
    @user = current_user
    if @user
      @parties = @user.parties
      @movies = @user.parties.map { |party| MovieServicer.movie_detail(party.movie_id) }
    else
      flash[:alert] = 'Must be logged in!'
      redirect_to root_path
    end
  end

  def discover
    @user = current_user
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
