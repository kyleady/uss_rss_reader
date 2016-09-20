# Article model.
#
# @since 0.0.1
class Article < ApplicationRecord
  belongs_to :feed
  after_create :clean

  def read(setViewed = true)
    update_attribute(:viewed,setViewed)
  end

  def viewed?
    viewed == true
  end

  private

  # It is possible for nil values to pop up in Articles, thus it is important to
  # clean those out
  def clean
    if title.nil?;       title       = '' end
    if description.nil?; description = '' end
    if link.nil?;        title       = '' end
    if author.nil?;      author      = '' end
    if pub_date.nil?;    pub_date    = '' end
  end

end
