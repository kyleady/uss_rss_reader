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
    @feed = Feed.find(params[:id])
  end

  def new
    @feed = Feed.new
  end

  def create
    if @user == nil
      redirect_to '/user/new'
      return
    end

    url = params[:feed][:url]
    validate_if_url url

    @feed = Feed.new(url: url)
    @user.feeds << @feed
    if @feed.valid?
      FeedsUpdateJob.new.perform(id: @feed.id)
      redirect_to feed_path(@feed)
    else
      render "new"
    end
  end

  def destroy
    @feed = Feed.find(params[:id]).destroy
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
end
