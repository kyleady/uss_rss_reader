class User < ApplicationRecord
  has_secure_password
  validates_presence_of :password, on: :create
  validates :email, uniqueness: :email

  def self.get_email(input_id)
    if input_id
      user = User.find(input_id)
      if user.respond_to?('email'); user.email else '' end
    else
      ''
    end
  end

end
