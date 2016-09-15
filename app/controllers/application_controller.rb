# Root application controller
#
# @since 0.0.1
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_feeds, :current_user

  def set_feeds
    @feeds   ||= Feed.all
    @newfeed ||= Feed.new
  end

  def current_user
    if cookies.permanent[:user]
      @user ||= User.find(cookies.permanent[:user])
    end
  end
end
