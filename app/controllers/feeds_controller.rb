require 'rss'
require 'open-uri'

class FeedsController < ApplicationController
  def new
    puts "This is a string for FeedsController < ApplicationController."
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
