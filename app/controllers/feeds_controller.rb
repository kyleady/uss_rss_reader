require 'rss'
require 'open-uri'

class FeedsController < ApplicationController
  def index
    @feeds = Feed.all
  end

  def show
    @feed = Feed.find(params[:id])
    @feed.show
  end

  def new
    @feed = Feed.new
  end

  def create
    url = params[:feed][:url]
    if url =~ /\A#{URI::regexp(['http', 'https'])}\z/
      @feed = Feed.new({
        url: params[:feed][:url]
      })
      if @feed.save
        FeedsUpdateJob.perform_async({})
        redirect_to feed_path(@feed)
      else
        redirect_to new_feed_path(:error => "URL already exists")
      end
    else
      redirect_to new_feed_path(:error => "Invalid URL")
    end
  end

  def destroy
    @feed = Feed.find(params[:id]).destroy
    redirect_to feeds_path
  end

  #takes the user's submited url and parses the rss feed there
  def parse_rss
    #creates a new Feed model, within the initialization the rss feed is pulled apart and saved
    feed = Feed.new(params[:q])
    #put the feed to the terminal to ensure everything is working correctly
    feed.show
    #let the user return to adding more feeds
    render :action => "new"
  end
end
