class UsersController < ApplicationController
  before_action :current_user, :check_user, only: %i[index discover dashboard]
  before_action :set_user, only: %i[show]

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

  def show; end

  def dashboard
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

  def set_user
    @user = begin
      User.friendly.find(params[:id])
    rescue StandardError
      not_found
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
