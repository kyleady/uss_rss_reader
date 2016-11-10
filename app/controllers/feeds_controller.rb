require 'rss'
require 'open-uri'

# The controller file for handling incoming feed data.
#
# @author [ Tyler Hampton, Kyle Ady ]
# @since 0.0.1
class FeedsController < ApplicationController
  def index
  end

  def show
    @feed = Feed.get cookies.permanent[:user], params
    not_found if @feed.nil?
    @articles = @feed.articles
  end

  def new
    @feed = Feed.new
  end

  def create
    if @user.nil?
      flash.alert = 'Please Create An Account'
      redirect_to new_user_path
    else
      @feed = Feed.new(url: params[:feed][:url])
      @user.feeds << @feed
      validate_feed
      @feed.articles.each {|article| ActionCable.server.broadcast("article_#{current_user.id}", feed: @feed.id, unread: true, full_display: render_to_string(article, full: true), link_display: render_to_string(article))}
    end
  end

  def destroy
    @feed = Feed.get cookies.permanent[:user], params
    if @feed.nil?
      not_found
    else
      @feed.articles.each {|article| ActionCable.server.broadcast("article_#{current_user.id}", edit: true, article: article.id, full_display: "", link_display: "")}
      @feed.destroy
      set_sidebar_variables
      ActionCable.server.broadcast("feed_#{current_user.id}", refresh_all: true, display: render_to_string(@feeds))
    end
  end

  private

  def validate_feed
    if @feed.valid?
      update_feed
    else
      not_found
    end
  end

  def update_feed
    if @feed.update
      ActionCable.server.broadcast("feed_#{current_user.id}", display: render_to_string(@feed))
    else
      @feed.destroy
      not_found
    end
  end

  def not_found
    flash.alert = 'Invalid Feed'
    redirect_to new_feed_path
  end
end
