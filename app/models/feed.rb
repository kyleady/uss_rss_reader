require 'rss'
require 'open-uri'

# Model for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class Feed < ApplicationRecord
  belongs_to :user
  has_many :articles, dependent: :destroy
  validates :url, uniqueness: :url

  def update
    open(url) do |rss|
      feed_data = RSS::Parser.parse(rss, false)
      case feed_data.feed_type
      when 'rss'
        parse_rss_feed(feed_data)
      when 'atom'
        parse_atom_feed(feed_data)
      end
    end
    true
  end

  def show
  end

  private

  def parse_rss_feed(feed_data)
    update_attributes(
      title:       careful_get(feed_data.channel, 'title'),
      description: careful_get(feed_data.channel, 'description')
    )
    parse_rss_articles(feed_data.items)
  end

  def parse_atom_feed(feed_data)
    update_attributes(
      title:       careful_get(feed_data, 'title', 'content'),
      description: careful_get(feed_data, 'subtitle', 'content')
    )
    parse_atom_articles(feed_data.items)
  end

  def parse_rss_articles(new_articles)
    new_articles.each do |new_article|
      duplicate = articles.find do |old_article|
        old_article.link == new_article.link
      end
      parse_rss_article(new_article) if duplicate.nil?
    end
  end

  def parse_atom_articles(new_articles)
    new_articles.each do |new_article|
      duplicate = articles.find do |old_article|
        old_article.link == new_article.link.href
      end
      parse_atom_article(new_article) if duplicate.nil?
    end
  end

  def parse_rss_article(new_article)
    articles << Article.new(
      title:       careful_get(new_article, 'title'),
      description: careful_get(new_article, 'description'),
      link:        careful_get(new_article, 'link'),
      author:      careful_get(new_article, 'author'),
      pub_date:    careful_get(new_article, 'pubDate')
    )
  end

  def parse_atom_article(new_article)
    articles << Article.new(
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
        second_object.respond_to?(second_method) ? second_object.send(second_method) : ''
      end
    else
      ''
    end
  end
end
