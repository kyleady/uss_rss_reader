class AddViewedToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :viewed, :boolean, null: false, default: false
  end
end
