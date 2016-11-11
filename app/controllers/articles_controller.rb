# Controller file for handling the display of collected articles from a feed.
#
# @since 0.0.1
class ArticlesController < ApplicationController
  def show
    @article = Article.get cookies.permanent[:user], params

    if @article.nil?
      not_found
    else
      @article.read
    end
  end

  def toggle_viewed
    @article = Article.get cookies.permanent[:user], params
    if @article.nil?
      not_found
    else
      @article.read(!@article.viewed?)
    end
  end

  private

  def not_found
    flash.alert = 'Article not found'
    redirect_to new_feed_path
  end
end
