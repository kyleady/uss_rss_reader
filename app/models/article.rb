# Article model.
#
# @since 0.0.1
class Article < ApplicationRecord
  belongs_to :feed
end
