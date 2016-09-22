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
    define_feed
  end

  def new
    @feed = Feed.new
  end

  def create
    @user.nil? ? redirect_to('user/new') : create_feed
  end

  def destroy
    define_feed
    @feed.destroy
    redirect_to feeds_path
  end

  def parse_rss
    feed = Feed.new(params[:q])
    feed.show
    render action: 'new'
  end

  private

  def validate_if_url(url)
    return if url =~ /\A#{URI.regexp(%w(http https))}\z/
    redirect_to new_feed_path(error: 'Invalid URL')
  end

  def define_feed
    @feed = Feed.find(params[:id])
    Feed.find(0) if @feed.user_id.to_s != cookies.permanent[:user]
  end

  def create_feed
    @feed = Feed.new(url: params[:feed][:url])
    @user.feeds << @feed
    if @feed.valid?
      FeedsUpdateJob.new.perform(id: @feed.id)
      redirect_to feed_path(@feed)
    else
      render :new
    end
  end
end
