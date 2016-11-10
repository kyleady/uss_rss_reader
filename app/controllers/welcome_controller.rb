# Controller that renders the index page.
#
# @since 0.0.1
class WelcomeController < ApplicationController
  def index
    @articles = unread_articles
  end
end
