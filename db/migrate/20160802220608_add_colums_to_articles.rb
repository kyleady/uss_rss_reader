class AddColumsToArticles < ActiveRecord::Migration[5.0]
  def change
    add_column :articles, :description, :string
    add_column :articles, :link, :string
    add_column :articles, :author, :string
    add_column :articles, :pub_date, :string
    add_column :articles, :guid, :string
  end
end
