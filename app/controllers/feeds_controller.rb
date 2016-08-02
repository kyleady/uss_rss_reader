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
    open(params[:feed][:url]) do |rss|
      feed_data = RSS::Parser.parse(rss)

      articles = feed_data.items.map { |item|
        Article.new({
          title: item.title,
          description: item.description,
          link: item.link,
          author: item.author,
          pub_date: item.pubDate,
          guid: item.guid
        })
      }

      @feed = Feed.new({
        title: feed_data.channel.title,
        description: feed_data.channel.description,
        articles: articles
      })

      @feed.save
    end

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
