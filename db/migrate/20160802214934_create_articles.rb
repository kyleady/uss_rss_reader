class CreateArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :articles do |t|
      t.string :title
      t.belongs_to :feed, foreign_key: true

      t.timestamps
    end
  end
end
