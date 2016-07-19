require 'rss'
require 'open-uri'

class FeedsController < ApplicationController
  def new
    puts "This is a string for FeedsController < ApplicationController."
  end

  def parse_rss
    url = params[:q]
    puts "\n\n\n==URL=="
    puts url
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      puts "Title: #{feed.channel.title}"
      feed.items.each do |item|
        puts "Item: #{item.title}"
      end
    end
    puts "\n\n\n"
    render :action => "new"

  end
end
