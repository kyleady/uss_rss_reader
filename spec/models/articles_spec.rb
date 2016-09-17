require 'rails_helper'

RSpec.describe Article, type: :model do
  context "should belong to feed" do
    it { should belong_to :feed}
  end
end
