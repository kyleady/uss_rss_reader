# Controller that renders the index page.
#
# @since 0.0.1
class WelcomeController < ApplicationController
  def index
    @articles = []
    @feeds.each { |feed| @articles.concat(feed.articles) } if @feeds
    @articles = @articles.select do |article|
      !article.viewed?
    end
  end
end
