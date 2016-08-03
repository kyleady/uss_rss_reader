class ArticlesController < ApplicationController

  def show
    feed = Feed.find(params[:feed_id])
    @article = feed.articles.find(params[:id])

  end

end
