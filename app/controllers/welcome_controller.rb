# Controller that renders the index page.
#
# @since 0.0.1
class WelcomeController < ApplicationController
  def index
    @feeds = Feed.all
    @newfeed = Feed.new
    @articles = Article.all
  end
end
