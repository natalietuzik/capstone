class SessionsController < ApplicationController
  def new
    redirect_to root_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email].to_s.downcase)
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      if params[:remember_me] == "1"
        user.remember
        cookies.permanent.signed[:user_id]       = user.id
        cookies.permanent[:remember_token]        = user.remember_token
      else
        cookies.delete(:user_id)
        cookies.delete(:remember_token)
      end
      flash[:notice] = "Welcome back, #{user.email}!"
      redirect_to root_path
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    if (user = current_user)
      user.forget
    end
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
    session[:user_id] = nil
    flash[:notice] = "You have been logged out."
    redirect_to login_path
  end
end
