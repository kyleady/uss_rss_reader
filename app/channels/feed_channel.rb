# Channel for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class FeedChannel < ApplicationCable::Channel
  def subscribed
    stream_from "feed_#{current_user.id}" if current_user
  end
end
