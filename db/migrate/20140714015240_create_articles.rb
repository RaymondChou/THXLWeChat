class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :image_url
      t.string :type, :limit => 16
      t.integer :sort, :default => 0
      t.text :content
      t.timestamps
    end
  end
end
