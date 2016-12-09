# Model for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class User < ApplicationRecord
  has_many :feeds, dependent: :destroy
  has_secure_password
  validates :password, presence: true
  validates :email, uniqueness: :email
end
