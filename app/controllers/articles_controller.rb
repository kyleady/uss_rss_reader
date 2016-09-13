# Controller file for handling the display of collected articles from a feed.
#
# @since 0.0.1
class ArticlesController < ApplicationController
  def show
    feed = Feed.find(params[:feed_id])
    @article = feed.articles.find(params[:id])
  end
end
