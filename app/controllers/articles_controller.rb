# Controller file for handling the display of collected articles from a feed.
#
# @since 0.0.1
class ArticlesController < ApplicationController
  def show
    feed = Feed.find(params[:feed_id])
    if "#{feed.user_id}" != cookies.permanent[:user]
      Feed.find(0)
    end
    @article = feed.articles.find(params[:id])
  end
end
