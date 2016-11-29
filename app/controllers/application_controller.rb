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

  def current_user
    User.find(cookies.permanent[:user])
  rescue
    nil
  end

  def unread_articles
    articles = []
    @feeds.each { |feed| articles.concat(feed.articles) unless feed.removing } if @feeds
    articles.select do |article|
      !article.viewed?
    end
  end

  private

  def set_current_user
    @user = current_user
  end

  def set_user_feeds
    @feeds = @user.nil? ? @feeds = [] : @user.feeds
    @newfeed ||= Feed.new
  end
end
