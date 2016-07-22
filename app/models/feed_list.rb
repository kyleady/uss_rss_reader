class FeedList < ApplicationRecord::Base
  #transform the feedlist text into an array
  serialize :feedlist, Array
  
  #when showing the feedlist, show every item in the list
  def show
    feedlist.each do |item|
      item.show
    end
  end

end
