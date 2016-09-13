class Article < ApplicationRecord
  belongs_to :feed
  before_save :clean

  private

  #It is possible for nil values to pop up in Articles, thus it is important to
  #clean those out
  def clean
    title       ||= ''
    description ||= ''
    link        ||= ''
    author      ||= ''
    guid        ||= ''
    pub_date    ||= ''
  end
end
