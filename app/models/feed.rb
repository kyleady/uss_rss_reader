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

      puts "\n\n================================\nUpdating " + title + "\n================================\n\n"

      add_articles(feed_data.items)
    end
  end

  def show
  end

  private

  def add_articles(newArticles)
    newArticles.each do |newArticle|
      duplicate = articles.find do |oldArticle|
        oldArticle.link == newArticle.link
      end

      return unless duplicate.nil?

      articles.push(
        Article.new(
          title:       newArticle.title,
          description: newArticle.description,
          link:        newArticle.link,
          author:      newArticle.author,
          pub_date:    newArticle.pubDate,
          guid:        newArticle.guid
        )
      )
    end
  end
end
