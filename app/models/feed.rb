class Feed < ApplicationRecord
  include ActiveModel::Validations

  attr_accessor :title, :url, :description

  #every feed must have a title, url, and description
  validates :title, presence: true
  validates :url, presence: true
  validates :description, presence: true

  #called when a new Feed is created
  def initialize(userURL)
    #save the url
    @url = userURL
    #prase the url as an rss feed
    open(@url) do |rss|
      getFeed = RSS::Parser.parse(rss)
      #save the title of the feed
      @title = getFeed.channel.title
      #save the description of the feed
      @description = getFeed.channel.description
    end
  end

  #show the feed
  def show
    puts "\n"
    puts @url
    puts @title
    puts @description
    puts "\n"
  end

end
