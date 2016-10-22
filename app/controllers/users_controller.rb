# The controller file for handling incoming feed data.
#
# @author [ Tyler Hampton, Kyle Ady ]
# @since 0.0.1
class UsersController < ApplicationController
  def index
  end

  def show
    if cookies.permanent[:user]
      @user = User.find(cookies.permanent[:user])
    else
      redirect_to :new
    end
  rescue
    not_found
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))
    if @user.valid? && @user.save
      cookies.permanent[:user] = @user.id
      redirect_to '/'
    else
      render :new
    end
  end

  def destroy
    @user = User.find(cookies.permanent[:user]).destroy
    cookies.delete :user
    redirect_to '/'
  rescue
    not_found
  end

  def logout
    cookies.delete :user
    redirect_to '/'
  end

  def sign_in
  end

  def begin_session
    find_user = User.find_by_email(params[:email])
    store_user_id find_user
  rescue
    not_found
  end

  def store_user_id(user)
    if user && user.authenticate(params[:password])
      cookies.permanent[:user] = user.id
      redirect_to '/', notice: 'Logged in!'
    else
      flash.alert = 'Invalid email or password'
      render 'sign_in'
    end
  end

  def not_found
    flash.alert = 'User not found'
    redirect_to 'sign_in'
  end
end
