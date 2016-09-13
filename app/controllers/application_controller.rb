# Root application controller
#
# @since 0.0.1
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_feeds

  def set_feeds
    @feeds   ||= Feed.all
    @newfeed ||= Feed.new
  end
end
