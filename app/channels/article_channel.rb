# Channel for articles.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class ArticleChannel < ApplicationCable::Channel
  def subscribed
    stream_from "article_#{current_user.id}" if current_user
  end
end
