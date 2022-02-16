class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      redirect_to user_path(@user)
    else
      flash.now[:user_errors] = 'User Not Registered'
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @invited_parties = @user.invites
    @movies = @user.parties.map { |party| MovieServicer.movie_detail(party.movie_id) }
    @host_parties = @user.hosting
  end

  def discover
    @user = User.find(params[:id])
  end

  def login_form; end

  def login
    user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), { flash: { success: "Welcome #{user.name}!" } }
      else
        flash[:invalid_password] = 'Invalid Password'
        render 'login_form'
      end
    else
      flash[:invalid_email] = "Couldn't find user with email #{params[:email]}"
      render 'login_form'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
