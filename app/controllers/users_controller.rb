# The controller file for handling incoming feed data.
#
# @author [ Tyler Hampton, Kyle Ady ]
# @since 0.0.1
class UsersController < ApplicationController
  def index

  end

  def show
    @user = User.find(cookies.permanent[:user])
  end

  def new
    @user = User.new
  end

  def create
    email = params[:user][:email]

    @user = User.new(params.require(:user).permit(:email, :password, :password_confirmation))

    if @user.save
      cookies.permanent[:user] = @user.id
      redirect_to "/"
    else
      redirect_to controller: "users", action: "new" , error: "The email address #{email} has already been taken"
    end
  end

  def destroy
    @user = User.find(cookies.permanent[:user]).destroy
    cookies.delete :user
    redirect_to "/"
  end

  def logout
    cookies.delete :user
    redirect_to "/"
  end

  def signin

  end

  def begin_session
    user = User.find_by_email(params[:email])
    if user.authenticate(params[:password])
      cookies.permanent[:user] = user.id
      redirect_to "/", notice: "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "signin"
    end
  end
end
