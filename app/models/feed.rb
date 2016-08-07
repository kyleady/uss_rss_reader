require 'rss'
require 'open-uri'

class Feed < ApplicationRecord
  ActiveRecord::Validations
  has_many :articles, dependent: :destroy
  validates_uniqueness_of :url

  def update
    open(url) do |rss|
      feed_data = RSS::Parser.parse(rss)

      update_attribute(:articles,feed_data.items.map { |item|
        Article.new({
          title: item.title,
          description: item.description,
          link: item.link,
          author: item.author,
          pub_date: item.pubDate,
          guid: item.guid
        })
      })
      update_attribute(:title,feed_data.channel.title)
      update_attribute(:description,feed_data.channel.description)
    end
    #update_attribute(:title,@title)
    #update_attribute(:description,@description)
    #update_attribute(:articles,@articles)
  end

  def show
  end
end
