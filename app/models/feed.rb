class Feed < ActiveRecord::Base
  #include ActiveModel::Validations


  attr_accessor :title, :url, :description


  serialize :items, Array

  #every feed must have a title, url, and description
  #validates :title, presence: true
  #validates :url, presence: true
  #validates :description, presence: true

  #called when a new Feed is created
  def update
    #prase the url as an rss feed
    open(@url) do |rss|
      getFeed = RSS::Parser.parse(rss)
      #save the title of the feed
      @title = getFeed.channel.title
      #save the description of the feed
      @description = getFeed.channel.description
      @items = [];
      getFeed.channel.items.each do |item|
        @items << FeedItem.new(item.title,item.description,item.link,item.author,item.pubDate,item.guid)
      end
    end
  end

  #show the feed
  def show
    puts "\n"
    puts "<URL>"
    puts @url
    puts "<Title>"
    puts @title
    puts "<Description>"
    puts @description
    puts "<Items>"
    if @items
      @items.each do |item|
        item.show
        puts "\n"
      end
    else
      puts @items
    end
  end

end

class FeedItem
  def initialize(title, description, link, author, pubDate,guid)
    @title = title
    @description = description
    @link = link
    @author = author
    @pubDate = pubDate
    @guid = guid
  end

  def show
    puts "  <title>"
    puts "  #{@title}"
    puts "  <description>"
    puts "  #{@description}"
    puts "  <link>"
    puts "  #{@link}"
    puts "  <author>"
    puts "  #{@author}"
    puts "  <pubDate>"
    puts "  #{@pubDate}"
    puts "  <guid>"
    puts "  #{@guid}"
  end
end
