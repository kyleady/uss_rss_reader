# Controller file for handling the display of collected articles from a feed.
#
# @since 0.0.1
class ArticlesController < ApplicationController
  def show
    define_article
    @article.read
  end

  def toggle_viewed
    define_article
    @article.read(!@article.viewed?)
    redirect_to :back
  end

  private

  def define_article
    feed = Feed.find(params[:feed_id])
    Feed.find(0) if feed.user_id.to_s != cookies.permanent[:user]
    @article = feed.articles.find(params[:id])
  end
end
