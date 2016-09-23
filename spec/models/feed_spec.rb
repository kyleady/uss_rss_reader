require 'rails_helper'

RSpec.describe Feed, type: :model do
  context 'should belong to a user' do
    it { should belong_to :user }
  end

  it { should have_many :articles }

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

  context '.get' do
    it 'with a nil user, returns nil' do
      @user = User.new(email: 'fake user', password: 'password')
      @user.save
      @feed = Feed.new(url: 'fake feed')
      @user.feeds << @feed
      expect(Feed.get(nil, id: @feed.id)).to eq(nil)
      @user.destroy
    end
    it 'with a non-matching user, returns nil' do
      @user = User.new(email: 'fake user', password: 'password')
      @user.save
      @feed = Feed.new(url: 'fake feed')
      @user.feeds << @feed
      wrong_id = @user.id+1
      expect(Feed.get(wrong_id, id: @feed.id)).to eq(nil)
      @user.destroy
    end
    it 'with a matching user, returns the feed' do
      @user = User.new(email: 'fake user', password: 'password')
      @user.save
      @feed = Feed.new(url: 'fake feed')
      @user.feeds << @feed
      expect(Feed.get(@user.id.to_s, id: @feed.id.to_s)).to eq(@feed)
      @user.destroy
    end
  end
end
