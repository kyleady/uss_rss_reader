# Model for feeds.
#
# @author [ Kyle Ady, Tyler Hampton ]
# @since 0.0.1
class User < ApplicationRecord
  has_many :feeds, dependent: :destroy
  has_secure_password
  validates :password, presence: true
  validates :email, uniqueness: :email

  def self.get_email(input_id)
    if input_id
      user = User.find(input_id)
      user.respond_to?('email') ? user.email : ''
    else
      ''
    end
  end
end
