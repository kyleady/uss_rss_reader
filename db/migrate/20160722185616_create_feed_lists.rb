class CreateFeedLists < ActiveRecord::Migration[5.0]
  def change
    create_table :feed_lists do |t|
      t.text :feedlist

      t.timestamps
    end
  end
end
