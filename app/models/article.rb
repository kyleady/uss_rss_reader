# Article model.
#
# @since 0.0.1
class Article < ApplicationRecord
  belongs_to :feed

  after_create :clean

  private

  def clean
    attributes.each { |item| item || '' }
  end
end
