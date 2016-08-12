require 'rss'
require 'open-uri'

# Model for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class Feed < ApplicationRecord
  has_many :articles, dependent: :destroy
  validates :url, uniqueness: :url

  def update
    open(url) do |rss|
      feed_data = RSS::Parser.parse(rss)

      update_attributes(
        articles: generate_articles(feed_data),
        title: feed_data.channel.title,
        description: feed_data.channel.description
      )
    end
  end

  def show
  end

  private

  def generate_articles(feed_data)
    feed_data.items.map do |item|
      Article.new(
        title: item.title,
        description: item.description,
        link: item.link,
        author: item.author,
        pub_date: item.pubDate,
        guid: item.guid
      )
    end
  end
end
