require 'rss'
require 'open-uri'

articles = []

url = 'http://www.smbc-comics.com/rss.php'
open(url) do |rss|
  feed = RSS::Parser.parse(rss)
  puts "Title: #{feed.channel.title}"
  articles = feed.items.map { |item|
    {
      title: item.title,
      description: item.description,
      link: item.link,
      author: item.author,
      pub_date: item.pubDate,
      guid: item.guid
    }
  }
end

puts articles
