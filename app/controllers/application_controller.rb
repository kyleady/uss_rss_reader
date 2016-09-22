# Root application controller
#
# @since 0.0.1
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_sidebar_variables

  def set_sidebar_variables
    set_current_user
    set_user_feeds
  end

  private

  def set_current_user
    @user = User.find(cookies.permanent[:user]) if cookies.permanent[:user]
  rescue
    @user = nil
  end

  def set_user_feeds
    @feeds = @user.nil? ? @feeds = [] : @user.feeds
    @newfeed ||= Feed.new
  end
end
