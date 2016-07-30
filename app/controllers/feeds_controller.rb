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
    @feed = Feed.new
    puts "\n\n\n"
    puts params[:feed][:url]
    @feed.url = params[:feed][:url]
    @feed.show
    @feed.update
    @feed.show
    @feed.save
    puts "\n\n<Save Errors>"
    puts @feed.save!

    redirect_to feed_path(@feed)
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
