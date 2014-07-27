class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.string :event
      t.string :url
      t.string :image_url
      t.timestamps
    end
  end
end
