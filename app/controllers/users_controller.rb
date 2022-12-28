class UsersController < ApplicationController
  before_action :current_user, :check_user, only: %i[index show discover]

  def index
    @users = current_user.user_list
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to dashboard_path
    else
      flash[:user_errors] = "User Not Registered: #{@user.errors.full_messages.join(', ')}"
      redirect_to register_path
    end
  end

  def show
    @parties = @user.parties
  end

  def discover
    @user = current_user
  end

  private

  def check_user
    @user = current_user
    if @user.nil?
      flash[:user] = 'Must be logged in!'
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
