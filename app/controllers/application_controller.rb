# Root application controller
#
# @since 0.0.1
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_sidebar_variables

  def set_sidebar_variables
    @user = User.find(cookies.permanent[:user]) if cookies.permanent[:user]
    @feeds = @user.nil? ? @feeds = [] : @user.feeds
    @newfeed ||= Feed.new
  end
end
