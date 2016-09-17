# Root application controller
#
# @since 0.0.1
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_sidebar_variables

  def set_sidebar_variables
    if cookies.permanent[:user]
      @user = User.find(cookies.permanent[:user])
    end
    if @user then @feeds = @user.feeds else @feeds = [] end
    @newfeed ||= Feed.new
  end
end
