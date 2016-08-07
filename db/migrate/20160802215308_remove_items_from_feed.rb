class RemoveItemsFromFeed < ActiveRecord::Migration[5.0]
  def change
    remove_column :feeds, :items, :text
  end
end
