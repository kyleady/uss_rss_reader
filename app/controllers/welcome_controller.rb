# Controller that renders the index page.
#
# @since 0.0.1
class WelcomeController < ApplicationController
  def index
    @articles = [];
    if @feeds
      @feeds.each { |feed| @articles.concat(feed.articles)}
    end
  end
end
