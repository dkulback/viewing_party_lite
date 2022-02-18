class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:email])
    if user
      if user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to user_path(user), { flash: { success: "Welcome #{user.name}!" } }
      else
        flash[:invalid_password] = 'Invalid Password'
        render 'new'
      end
    else
      flash[:invalid_email] = "Couldn't find user with email #{params[:email]}"
      render 'new'
    end
  end

  def destroy
    session.destroy
    redirect_to root_path
  end
end
