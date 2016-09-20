require 'rails_helper'

RSpec.describe Article, type: :model do
  context "should belong to feed" do
    it { should belong_to :feed}
  end

  context "should report having been viewed" do
    it "after reading it" do
      article = Article.new
      article.read
      expect(article.viewed?).to eq(true)
    end
  end
end
