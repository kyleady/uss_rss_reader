class AddItemsToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :items, :text
  end
end
