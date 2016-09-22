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
  end

  def logout
    cookies.delete :user
    redirect_to '/'
  end

  def sign_in
  end

  def begin_session
    find_user = User.find_by_email(params[:email])
    if find_user && find_user.authenticate(params[:password])
      cookies.permanent[:user] = find_user.id
      redirect_to '/', notice: 'Logged in!'
    else
      flash.alert = 'Invalid email or password'
      redirect_to :sign_in
    end
  end
end
