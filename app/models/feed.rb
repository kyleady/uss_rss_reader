require 'rss'
require 'open-uri'

class Feed < ApplicationRecord
  ActiveRecord::Validations
  has_many :articles, dependent: :destroy
  validates_uniqueness_of :url

  def update
    open(url) do |rss|
      feed_data = RSS::Parser.parse(rss, false)

      case feed_data.feed_type
        when 'rss'
          parse_rss_feed(feed_data)
          parse_rss_articles(feed_data.items)
        when 'atom'
          parse_atom_feed(feed_data)
          parse_atom_articles(feed_data.items)
      end
    end
    true
  end

  def show
  end

  private

  def parse_rss_feed(feed_data)
    update_attributes(
      title:       feed_data.channel.respond_to?('title')       ? feed_data.channel.title       : '',
      description: feed_data.channel.respond_to?('description') ? feed_data.channel.description : ''
    )
  end

  def parse_atom_feed(feed_data)
    update_attributes(
      title:       feed_data.respond_to?('title')    ? feed_data.title.content : '',
      description: feed_data.respond_to?('subtitle') ? feed_data.subtitle.content : ''
    )
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
        title:       new_article.respond_to?('title')       ? new_article.title       : '',
        description: new_article.respond_to?('description') ? new_article.description : '',
        link:        new_article.respond_to?('link')        ? new_article.link        : '',
        author:      new_article.respond_to?('author')      ? new_article.author      : '',
        guid:        new_article.respond_to?('guid')        ? new_article.guid        : '',
        pub_date:    new_article.respond_to?('pubDate')     ? new_article.pubDate     : ''
      )
  end

  def parse_atom_article(new_article)
    articles << Article.new(
        title:       new_article.respond_to?('title')     ? new_article.title.content     : '',
        description: new_article.respond_to?('summary')   ? new_article.summary.content   : '',
        link:        new_article.respond_to?('link')      ? new_article.link.href         : '',
        author:      new_article.respond_to?('author')    ? new_article.author            : '',
        guid:        new_article.respond_to?('id')        ? new_article.id.content        : '',
        pub_date:    new_article.respond_to?('published') ? new_article.published         : ''
      )
  end
end
