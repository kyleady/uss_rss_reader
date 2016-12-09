class AddRemovingToFeeds < ActiveRecord::Migration[5.0]
  def change
    add_column :feeds, :removing, :boolean, null: false, default: false
  end
end
