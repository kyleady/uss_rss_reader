# Model for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class Article < ApplicationRecord
  belongs_to :feed
  after_create :clean

  def read(setViewed = true)
    update_attribute(:viewed, setViewed)
  end

  def viewed?
    viewed == true
  end

  def self.get(user_id, args)
    feed = Feed.get user_id, id: args[:feed_id]
    return nil if feed.nil?
    Article.find args[:id]
  rescue
    nil
  end

  def render(args = {})
    ApplicationController.render(self, locals: args)
  end

  def broadcast
    user_id = Feed.find(feed_id).user_id
    ActionCable.server.broadcast("article_#{user_id}",
                                  feed: feed_id,
                                  article: id,
                                  unread: !viewed?,
                                  full_display: render(full: true),
                                  link_display: render(full: false))
  end

  private

  def clean
    @title       = '' if @title.nil?
    @description = '' if @description.nil?
    @link        = '' if @link.nil?
    @author      = '' if @author.nil?
    @pub_date    = '' if @pub_date.nil?
  end
end
