# Model for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class Article < ApplicationRecord
  belongs_to :feed
  after_create :clean

  def read(setViewed = true)
    update_attribute(:viewed, setViewed)
  end

  def viewed?
    viewed == true
  end

  private

  def clean
    @title       = '' if @title.nil?
    @description = '' if @description.nil?
    @link        = '' if @link.nil?
    @author      = '' if @author.nil?
    @pub_date    = '' if @pub_date.nil?
  end
end
