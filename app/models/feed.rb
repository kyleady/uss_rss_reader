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
        title: feed_data.channel.title,
        description: feed_data.channel.description
      )

      add_articles(feed_data.items)
    end
  end

  def show
  end

  private

  def add_articles(new_articles)
    new_articles.each do |new_article|
      duplicate = articles.find do |old_article|
        old_article.link == new_article.link
      end

      add_article(new_article) if duplicate.nil?
    end
  end

  def add_article(new_article)
    articles.push(
      Article.new(
        title:       new_article.title,
        description: new_article.description,
        link:        new_article.link,
        author:      new_article.author,
        pub_date:    new_article.pubDate,
        guid:        new_article.guid
      )
    )
  end
end
