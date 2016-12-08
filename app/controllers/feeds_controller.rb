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
    if @feed.nil?
      not_found
    else
      @articles = @feed.articles
    end
  end

  def new
    @feed = Feed.new
  end

  def create
    if @user.nil?
      flash.alert = 'Please Create An Account'
      redirect_to new_user_path
    else
      @feed = Feed.new(url: standardize_url(params[:feed][:url]) )
      @user.feeds << @feed
      validate_feed
    end
  end

  def destroy
    @feed = Feed.get cookies.permanent[:user], params
    if @feed.nil?
      not_found
    else
      @feed.hide
      set_sidebar_variables
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
      @feed.show
    else
      @feed.destroy
      not_found
    end
  end

  def not_found
    flash.alert = 'Invalid Feed'
    redirect_to new_feed_path
  end

  def standardize_url(url)
    url = url.downcase
    'http://' + url unless /$http:\/\//
  end
end
