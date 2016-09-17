class RemoveGuidFromArticles < ActiveRecord::Migration[5.0]
  def change
    remove_column :articles, :guid, :string
  end
end
