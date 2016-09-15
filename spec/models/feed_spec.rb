require 'rails_helper'

RSpec.describe Feed, type: :model do
  context 'updates a' do
    it 'bogus url' do
      @feed = Feed.new(url: 'bogus url')
      expect(@feed.update).to eq(false)
    end
    it 'non-feed' do
      @feed = Feed.new(url: 'http://www.smbc-comics.com/')
      expect(@feed.update).to eq(false)
    end
    it 'rss feed' do
      @feed = Feed.new(url: 'http://www.smbc-comics.com/rss.php')
      expect(@feed.update).to eq(true)
    end
    it 'atom feed' do
      @feed = Feed.new(url: 'https://gist.githubusercontent.com/ToddG/1974656/raw/d2d2fd1f7c01b43a67b1c5f39694d9ab5e00903f/sample-atom-1.0-feed.xml')
      expect(@feed.update).to eq(true)
    end
  end
end
