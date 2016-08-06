class Feed < ApplicationRecord
  ActiveRecord::Validations
  has_many :articles, dependent: :destroy
  validates_uniqueness_of :url

  def update
  end

  def show
  end
end
