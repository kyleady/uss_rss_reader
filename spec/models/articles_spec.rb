require 'rails_helper'

RSpec.describe Article, type: :model do
  context 'should belong to feed' do
    it { should belong_to :feed }
  end

  context 'should report having been viewed' do
    it 'after reading it' do
      article = Article.new
      article.read
      expect(article.viewed?).to eq(true)
    end
  end

  context '.get' do
    it 'with a nil user, returns nil' do
      @user = User.new(email: 'fake user', password: 'password')
      @user.save
      @feed = Feed.new(url: 'fake feed')
      @user.feeds << @feed
      @article = Article.new(title: 'fake article')
      @feed.articles << @article
      expect(Article.get(nil, id: @article.id, feed_id: @feed.id)).to eq(nil)
      @user.destroy
    end
    it 'with a non-matching user, returns nil' do
      @user = User.new(email: 'fake user', password: 'password')
      @user.save
      @feed = Feed.new(url: 'fake feed')
      @user.feeds << @feed
      @article = Article.new(title: 'fake article')
      @feed.articles << @article
      wrong_id = @user.id + 1
      expect(Article.get(wrong_id, id: @article.id, feed_id: @feed.id)).to eq(nil)
      @user.destroy
    end
    it 'with a matching user, returns the article' do
      @user = User.new(email: 'fake user', password: 'password')
      @user.save
      @feed = Feed.new(url: 'fake feed')
      @user.feeds << @feed
      @article = Article.new(title: 'fake article')
      @feed.articles << @article
      expect(Article.get(@user.id.to_s, id: @article.id, feed_id: @feed.id)).to eq(@article)
      @user.destroy
    end
  end
end
