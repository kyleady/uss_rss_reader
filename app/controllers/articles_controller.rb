# Controller file for handling the display of collected articles from a feed.
#
# @since 0.0.1
class ArticlesController < ApplicationController
  def show
    @feeds = Feed.all
    @newfeed = Feed.new
    feed = Feed.find(params[:feed_id])
    @article = feed.articles.find(params[:id])
  end
end
