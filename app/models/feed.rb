require 'rss'
require 'open-uri'

# Model for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class Feed < ApplicationRecord
  belongs_to :user
  has_many :articles, dependent: :destroy
  validates :url, uniqueness: { scope: :user_id, message: 'Duplicate feed' }

  def self.get(user_id, args)
    feed = Feed.find args[:id]
    user_id == feed.user_id.to_s ? feed : nil
  rescue
    nil
  end

  def update
    if !removing
      update_valid_feed
    else
      destroy
    end
    true
  rescue
    false
  end

  def render(args = {})
    ApplicationController.render(self, locals: args)
  end

  def show
    ActionCable.server.broadcast("feed_#{user_id}",
                                 full_display: render(full: true),
                                 link_display: render)
  end

  def hide
    update_attribute(:removing, true)
    articles.each { |article| article.hide(user_id) }
    ActionCable.server.broadcast("feed_#{user_id}", feed: id, full_display: '', link_display: '')
  end

  private

  def update_valid_feed
    open(url) do |rss|
      feed_data = RSS::Parser.parse(rss, false)
      oldtitle = title
      parse_main_feed(feed_data)
      if oldtitle == title
        parse_articles(feed_data.items, feed_data.feed_type)
      else
        FeedsUpdateJob.perform_async(id: id)
      end
    end
  end

  def parse_main_feed(feed_data)
    case feed_data.feed_type
    when 'rss'
      update_attributes(title:       careful_get(feed_data.channel, 'title'),
                        description: careful_get(feed_data.channel, 'description'))
    when 'atom'
      update_attributes(title:       careful_get(feed_data, 'title', 'content'),
                        description: careful_get(feed_data, 'subtitle', 'content'))
    end
  end

  def parse_articles(new_articles, feed_type)
    new_articles.each do |new_article|
      duplicate = articles.find do |old_article|
        old_article.link == careful_get(new_article, 'link', 'href')
      end
      add_article(new_article, feed_type) if duplicate.nil?
    end
  end

  def add_article(new_article, feed_type)
    article = parse_rss_article(new_article) if feed_type == 'rss'
    article = parse_atom_article(new_article) if feed_type == 'atom'
    articles << article
    article.show(user_id)
  end

  def parse_rss_article(new_article)
    Article.new(
      title:       careful_get(new_article, 'title'),
      description: careful_get(new_article, 'description'),
      link:        careful_get(new_article, 'link'),
      author:      careful_get(new_article, 'author'),
      pub_date:    careful_get(new_article, 'pubDate')
    )
  end

  def parse_atom_article(new_article)
    Article.new(
      title:       careful_get(new_article, 'title', 'content'),
      description: careful_get(new_article, 'summary', 'content'),
      link:        careful_get(new_article, 'link', 'href'),
      author:      careful_get(new_article, 'author', 'content'),
      pub_date:    careful_get(new_article, 'published', 'content')
    )
  end

  def careful_get(object, method, second_method = nil)
    if object.respond_to?(method)
      second_object = object.send(method.to_sym)
      if second_method.nil?
        second_object
      else
        second_object.respond_to?(second_method) ? second_object.send(second_method) : second_object
      end
    else
      ''
    end
  end
end
