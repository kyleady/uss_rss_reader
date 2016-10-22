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
    end
  end

  def destroy
    @feed = Feed.get cookies.permanent[:user], params
    if @feed.nil?
      not_found
    else
      @feed.destroy
      redirect_to feeds_path
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
      redirect_to feed_path(@feed)
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
